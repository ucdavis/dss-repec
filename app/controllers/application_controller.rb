class ApplicationController < ActionController::Base
  before_action :authenticate

  def authenticate
    CASClient::Frameworks::Rails::Filter.filter(self)

    @loginid = session[:cas_user]

    unless User.find_by(loginid: @loginid)
      #TODO: redirect to forbidden
      flash[:danger] = "You don't have access"
  
    end
  end
end
