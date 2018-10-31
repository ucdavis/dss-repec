class ApplicationController < ActionController::Base
  before_action :authenticate

# What you need to do is first check if `session[:cas_user]` exists.
# If it does, you can start using it and you should not call `CASClient::Frameworks::Rails::Filter.filter(self)`.
# If `session[:cas_user]` does not exist, call `CASClient::Frameworks::Rails::Filter.filter(self)`
# and immediately return.

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
