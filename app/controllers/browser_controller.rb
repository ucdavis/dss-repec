class BrowserController < ApplicationController
  skip_before_action :authenticate, only: [:index, :show_rdf]

  # GET /papers
  # GET /papers.json
  def index
    @papers = Paper.includes(:authors).all

    @path = params[:path]

    render layout: 'browser'
  end

  def show_rdf
    @paper = Paper.find(params[:id])

    render action: 'show', formats: :rdf
  end
end
