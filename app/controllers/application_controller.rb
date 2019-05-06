class ApplicationController < ActionController::Base
  def check_login
    unless session[:user_id]
      redirect_to login_path
    else
      @logged_in = true
    end
  end
end
