class BrowserController < ApplicationController
  skip_before_action :authenticate, only: [:index, :show_redif]

  # GET /papers
  # GET /papers.json
  def index
    @papers = Paper.includes(:authors).order(:id).all

    @path = params[:path]

    headers['Content-Type'] = 'text/html; charset=utf-8'

    render layout: 'browser'
  end

  def show_redif
    @paper = Paper.find(params[:id])

    # RePEc protocol requires we serve files as UTF-8 with file extension .redif
    headers['Content-Type'] = 'text/plain; charset=utf-8'

    render action: 'show', formats: :redif
  end
end
