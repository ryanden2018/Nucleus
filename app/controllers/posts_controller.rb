class PostsController < ApplicationController

  skip_before_action :redirect_if_not_logged_in, only: [:show]

    def show
      @post = Post.find(params[:id])
      @post_user_name = @post.user&.username
      @is_plus = Pluss.find_by(user_id:@user_id,post_id:@post.id)&.is_plus
      @comments = @post.comments.uniq.sort_by { |c| (-1)*c.created_at.to_i }
      @comment = Comment.new
    end

    def new
      @post = Post.new
      @user = User.find(@user_id)
      @groups = @user.groups
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
      @user = User.find(@user_id)
      @groups = @user.groups
    end

    def update
      @post = Post.find(params[:id])
      @post.assign_attributes(post_params)
      if @post.valid?
        @post.edited = true
        @post.save
        redirect_to post_path(@post)
      else
        flash[:errors] = @post.errors.full_messages
        redirect_to edit_post_path(@post)
      end
    end

    def destroy
      @post = Post.find(params[:id])
      @group_posts = GroupPost.where(post_id: @post.id)
      @group_posts.each do |gp|
        gp.destroy
      end
      @post.destroy
      redirect_to launchpad_path
    end

    private

    def post_params
      params.require(:post).permit(:title,:content,:user_id,:image_url,group_ids:[])
    end
    
end
