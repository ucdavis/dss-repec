# Credit: https://github.com/rails/rails/issues/31419#issuecomment-399118697
class FilesController < ActionController::API
  include ActionController::Live
  before_action :setup_response_headers

  def show
    disk_service.download(params[:key]) do |chunk|
      response.stream.write(chunk)
    end
  ensure
    response.stream.close
  end

  private

  def setup_response_headers
    response.headers['Content-Type'] = params[:content_type] || DEFAULT_SEND_FILE_TYPE
    response.headers['Content-Disposition'] = params[:disposition] || DEFAULT_SEND_FILE_DISPOSITION
  end

  def disk_service
    ActiveStorage::Blob.service
  end
end
