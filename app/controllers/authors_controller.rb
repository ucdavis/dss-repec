class AuthorsController < ApplicationController
  def new
  end

  def create
    @paper = Paper.find(params[:paper_id])
    @author = @paper.authors.create(author_params)
    redirect_to paper_path(@paper)
  end

  def destroy
    @paper = Paper.find(params[:paper_id])
    @author = @paper.authors.find(params[:id])
    @author.destroy
    redirect_to paper_path(@paper)
  end

private
  def author_params
    params.require(:comment).permit(:names)
  end
end
