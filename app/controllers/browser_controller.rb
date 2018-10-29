class BrowserController < ApplicationController

  # GET /papers
  # GET /papers.json
  def index
    @papers = Paper.all
    @path = params[:path]

    render layout: false
  end

  def show_rdf
    @paper = Paper.find(params[:id])
  end
end
