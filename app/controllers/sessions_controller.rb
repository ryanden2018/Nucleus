class SessionsController < ApplicationController
  skip_before_action :redirect_if_not_logged_in, only: [:new,:create,:destroy]

  def new
  end

  def create
    @user = User.find_by(username: params[:username])
    if @user
      if @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect_to launchpad_path
      else
        flash[:errors] = ["Incorrect password"]
        redirect_to new_session_path
      end
    else
      flash[:errors] = ["Username not found"]
      redirect_to new_session_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to new_session_path
  end

  private
end
