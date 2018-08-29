class BrowserController < ApplicationController
  #before_action :set_paper, only: [:show, :edit, :update, :destroy]

  # GET /papers
  # GET /papers.json
  def index
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
