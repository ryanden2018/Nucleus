class ApplicationController < ActionController::Base
  before_action :check_login
  def check_login
    unless session[:user_id]
      redirect_to new_session_path
    else
      @logged_in = true
      @username = User.find(session[:user_id]).username
      @user_id = session[:user_id].to_i
      @user = User.find(@user_id)
    end
  end
end
