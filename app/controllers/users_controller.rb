class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  add_breadcrumb "Users", :users_path

  # GET /users
  # GET /users.json
  def index
    @users = User.search(params[:search]).order(:loginid).page(params[:page]).per(30)
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
    add_breadcrumb "Show user", @user
  end

  # GET /users/new
  def new
    @user = User.new
    add_breadcrumb "Create user", new_user_path
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
    add_breadcrumb "Edit user", edit_user_path
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html {
          flash[:success] = "User was successfully created."
          redirect_to @user
        }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html {
          flash[:success] = 'User was successfully updated.'
          redirect_to @user
        }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html {
        flash[:success] = 'User was successfully destroyed.'
        redirect_to users_url
      }
      format.json { head :no_content }
    end
  end

  def destroy_multiple
    User.destroy(params[:users])

    respond_to do |format|
      format.html { redirect_to users_path }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:loginid)
    end
end
