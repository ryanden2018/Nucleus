class UsersController < ApplicationController

  skip_before_action :redirect_if_not_logged_in, only: [:new,:create]

    def show
      @user = User.find(@user_id)
      @show_user = User.find(params[:id])
      @show_user_posts = @show_user.posts
      if (@user != @show_user) && (!Friendship.are_friends(@user,@show_user))
        redirect_to launchpad_path
      end
    end

    def new
      @user = User.new
    end

    def create
      @user = User.new(user_params)
      set_default_avatar
      if @user.valid?
        @user.save
        session[:user_id] = @user.id
        redirect_to launchpad_path
      else
        flash[:errors] = @user.errors.full_messages
        redirect_to new_user_path
      end
    end

    def edit
      check_auth
    end

    def update
      check_auth
      @user.assign_attributes(user_params)
      if @user.valid?
        @user.save
        redirect_to launchpad_path
      else
        flash[:errors] = @user.errors.full_messages
        redirect_to edit_user_path(session[:user_id])
      end

    end

    def destroy
      check_auth
      session[:user_id] = nil
      @user.destroy
      redirect_to new_session_path
    end


    private

    def user_params
      params.require(:user).permit(:username, :password, :password_confirmation, :first_name, :last_name, :age, :email, :bio, :avatar_url)
    end

    def set_default_avatar
      @user.avatar_url = "/assets/Quarkette.png"
    end
    
    def check_auth
      if @user_id != params[:id]
        redirect_to launchpad_path
      end
    end
    
end
