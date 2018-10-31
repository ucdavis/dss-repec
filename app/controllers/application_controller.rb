class ApplicationController < ActionController::Base
  before_action :authenticate

  def authenticate
    CASClient::Frameworks::Rails::Filter.filter(self)

    @loginid = session[:cas_user]

    if @loginid
      @user = User.find_by(loginid: @loginid)

      unless @user
        render 'users/unauthorized', status: :forbidden
      end
    end
  end
end
