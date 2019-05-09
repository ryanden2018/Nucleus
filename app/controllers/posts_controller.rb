class PostsController < ApplicationController

  skip_before_action :redirect_if_not_logged_in, only: [:show]

    def show
      @post = Post.find(params[:id])
      check_auth_to_view
      @post_user_name = @post.user&.username
      @is_plus = Pluss.find_by(user_id:@user_id,post_id:@post.id)&.is_plus
      @comments = @post.comments.uniq.sort_by { |c| (-1)*c.created_at.to_i }
      @comment = Comment.new
    end

    def new
      @post = Post.new
      @user = User.find(@user_id)
      @groups = @user.groups.uniq
    end

    def create
      @post = Post.new(post_params)
      set_flag_and_hide_and_edit
      if @post.valid?
        @post.edited = false
        @post.save
        if @post.private
          GroupPost.delete_all_for_post(@post)
        end
        redirect_to post_path(@post)
      else
        flash[:errors] = @post.errors.full_messages
        redirect_to new_post_path
      end
    end

    def edit
      @post = Post.find(params[:id])
      @groups = @user.groups.uniq
      check_auth_to_change
    end

    def update
      @post = Post.find(params[:id])
      if params[:flag_button]
        @post.is_flagged = true
        @post.save
        redirect_to @post
      elsif check_auth_to_change
        @post.assign_attributes(post_params)
        if @post.valid?
          @post.edited = true
          @post.save
          if @post.private
            GroupPost.delete_all_for_post(@post)
          end
          redirect_to post_path(@post)
        else
          flash[:errors] = @post.errors.full_messages
          redirect_to edit_post_path(@post)
        end
      end
    end

    def destroy
      @post = Post.find(params[:id])
      if check_auth_to_change
        @group_posts = GroupPost.where(post_id: @post.id)
        @group_posts.each do |gp|
          gp.destroy
        end
        @post.destroy
        redirect_to launchpad_path
      end
    end

    private

    def post_params
      params.require(:post).permit(:title,:content,:user_id,:image_url,:private,:is_flagged,:id_hidden,group_ids:[])
    end

    def set_flag_and_hide_and_edit
      @post.is_flagged = false
      @post.is_hidden = false
      @post.edited = false
    end

    def check_auth_to_view
      if !@post.authorized_to_view(@user)
        redirect_to launchpad_path
        false
      else
        true
      end
    end

    def check_auth_to_change
      if @post.user_id != @user_id
        redirect_to launchpad_path
        false
      else
        true
      end
    end
    
end
