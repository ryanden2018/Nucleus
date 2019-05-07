class ApplicationController < ActionController::Base
  before_action :check_login

  def check_login
    unless session[:user_id]
      redirect_to login_path
    else
      @logged_in = true
      @username = User.find(session[:user_id]).username
      @user_id = session[:user_id]
    end
  end
end
