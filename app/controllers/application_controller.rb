class ApplicationController < ActionController::Base
  before_action :check_login
  before_action :redirect_if_not_logged_in

  def check_login
    if session[:user_id]
      @logged_in = true
      @username = User.find(session[:user_id]).username
      @user_id = session[:user_id].to_i
      @user = User.find(@user_id)
    end
  end

  def redirect_if_not_logged_in
    if !@logged_in
      redirect_to new_session_path
    end
  end
end
