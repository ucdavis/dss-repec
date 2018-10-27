class BrowserController < ApplicationController
  #before_action :set_paper, only: [:show, :edit, :update, :destroy]

  # GET /papers
  # GET /papers.json
  def index
    @papers = Paper.all
    @path = params[:path]

    render layout: false
  end

  def show_rdf
    @paper = Paper.find(params[:id])



    # send_file "#{@paper.paper_number}.rdf",
    #   :filename => "#{@paper.title}",
    #       :type => "application/pdf",
    #   :disposition => 'attachment'
    #
    # flash[:notice] = "Your file has been downloaded"
    render action: "show", formats: :rdf



  #  respond_to do |format|
  #        format.html
  #        format.rdf { render rdf: generate_rdf(@paper) }
  #  end
  end











  # private
  #   # Use callbacks to share common setup or constraints between actions.
  #   def set_paper
  #     @paper = Paper.find(params[:id])
  #   end

  #   # Never trust parameters from the scary internet, only allow the white list through.
  #   def paper_params
  #     params.require(:paper).permit(:Author, :Title)
  #   end
end
