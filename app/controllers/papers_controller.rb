class PapersController < ApplicationController
  before_action :set_paper, only: [:show, :edit, :update, :destroy]
  add_breadcrumb "Papers", :papers_path

  # GET /papers
  # GET /papers.json
  def index
    @papers = Paper.search(params[:search]).order(created_at: :desc).page(params[:page]).per(30)
  end

  # GET /papers/1
  # GET /papers/1.json
  def show
    @paper = Paper.find(params[:id])
    add_breadcrumb "Show paper", @paper
  end

  # GET /papers/new
  def new
    @paper = Paper.new
    add_breadcrumb "Add paper", new_paper_path
  end

  # GET /papers/1/edit
  def edit
    @paper = Paper.find(params[:id])
    @priorities = {}
    @paper.authors_papers.each do |authors_paper|
      author_id = authors_paper.author_id
      @priorities[author_id] = authors_paper.priority
    end
    add_breadcrumb "Edit author", edit_paper_path
  end

  # POST /papers
  # POST /papers.json
  def create
    create_params = paper_params
    author_priorities = paper_params[:priorities].to_h.reject{ |k,v| v.empty? }
    create_params[:author_ids] = author_priorities.keys

    @paper = Paper.new(create_params.except(:priorities))
    @paper.paper_number = Paper.maximum('paper_number') + 1

    respond_to do |format|
      if @paper.save
        author_priorities.each do |id, priority|
          @paper.authors_papers.where(:author_id => id).update_all(priority: priority)
        end

        format.html {
          flash[:success] = "Paper was successfully created."
          redirect_to @paper
        }
        format.json { render :show, status: :created, location: @paper }
      else
        format.html { render :new }
        format.json { render json: @paper.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /papers/1
  # PATCH/PUT /papers/1.json
  def update
    update_params = paper_params
    author_priorities = paper_params[:priorities].to_h.reject{ |k,v| v.empty? }
    update_params[:author_ids] = author_priorities.keys

    respond_to do |format|
      if @paper.update(update_params.except(:priorities))

          author_priorities.each do |id, priority|
            @paper.authors_papers.where(:author_id => id).update_all(priority: priority)
          end

        format.html {
          flash[:success] = "Paper was successfully updated."
          redirect_to @paper
        }
        format.json { render :show, status: :ok, location: @paper }
      else
        format.html { render :edit }
        format.json { render json: @paper.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /papers/1
  # DELETE /papers/1.json
  def destroy
    @paper.destroy
    respond_to do |format|
      format.html {
        flash[:success] = "Paper was successfully destroyed."
        redirect_to papers_url
      }
      format.json { head :no_content }
    end
  end

  def destroy_multiple
    Paper.destroy(params[:papers])

    respond_to do |format|
      format.html { redirect_to papers_path }
      format.json { head :no_content }
    end
  end

private
  # Use callbacks to share common setup or constraints between actions.
  def set_paper
    @paper = Paper.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def paper_params
    params.require(:paper).permit(:file, :title, :text, :paper_number, :paper_length, :abstract, :keywords, :creation_date, :classification_jel, author_ids: [], priorities: {})
  end
end
