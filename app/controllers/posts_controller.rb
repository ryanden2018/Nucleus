class PostsController < ApplicationController
    before_action :check_login

    def index

    end

    def show
      @post = Post.find(params[:id])
    end

    def new
      @post = Post.new
      @user = User.find(session[:user_id])
    end

    def create
      @post = Post.new(post_params)
      if @post.valid?
        @post.edited = false
        @post.save
        redirect_to post_path(@post)
      else
        flash[:errors] = @post.errors.full_messages
        redirect_to new_post_path
      end
    end

    def edit
      @post = Post.find(params[:id])
      @user = User.find(session[:user_id])
    end

    def update

    end

    def destroy

    end

    private

    def post_params
      params.require(:post).permit(:title,:content,:user_id, group_ids:[])
    end
    
end
