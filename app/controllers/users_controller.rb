class UsersController < ApplicationController

  # before_action  :set_default_avatar, only: :create
  skip_before_action :check_login, only: [:new,:create]

    def show
      @user = User.find(@user_id)
      @show_user = User.find_by(username:params[:username])
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
      @user = User.find(session[:user_id])
    end

    def update
      @user = User.find(session[:user_id])
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
      @user = User.find(session[:user_id])
      session[:user_id] = nil
      @user.destroy
      redirect_to login_path
    end


    private

    def user_params
      params.require(:user).permit(:username, :password, :password_confirmation, :first_name, :last_name, :age, :email, :bio, :avatar_url)
    end

    def set_default_avatar
      @user.avatar_url = "/app/assets/images/Quarky.png"
    end

    # <%# t.string "username"
    # t.string "password_digest"
    # t.string "first_name"
    # t.string "last_name"
    # t.integer "age"
    # t.string "email"
    # t.string "avatar_url"
    # t.string "bio" %>


    
    
end
