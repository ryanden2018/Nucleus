class UsersController < ApplicationController

  before_action  :set_default_avatar, only: :create
  skip_before_action :check_login, only: [:new,:create]
    def index
      @user = User.find(@user_id)
      @posts = Post.all
      @users = User.all
      @friend_requesters = @user.senders
    end
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
      if @user.valid?
        @user.save
        session[:user_id] = @user.id
        redirect_to launchpad_path
      else
        redirect_to user_new_path
      end
    end

    def edit
      @user = User.find(@user_id)
    end

    def update

    end

    def destroy

    end


    private

    def user_params
      params.require(:user).permit(:username, :password_digest, :first_name, :last_name, :age, :email, :bio)
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
