class BrowserController < ApplicationController
  skip_before_action :authenticate, only: [:index, :show_rdf]

  # GET /papers
  # GET /papers.json
  def index
    @papers = Paper.all
    @path = params[:path]

    render layout: false
  end

  def show_rdf
    @paper = Paper.find(params[:id])

    render action: "show", formats: :rdf
  end
end
