class ApplicationController < ActionController::Base
  before_action :authenticate

  def authenticate
    unless cas_login
      head :unauthorized
      return
    end

    @loginid = cas_login

    if @loginid
      @user = User.find_by(loginid: @loginid)

      unless @user
        render 'users/unauthorized', status: :forbidden
      end
    end
  end

  private

  def cas_login
    session.dig('cas', 'user')
  end
end
