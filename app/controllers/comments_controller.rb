class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    set_flag_and_hide_and_edit
    @post = Post.find(comment_params[:post_id])
    if @comment.valid?
      @comment.save
      redirect_to @post
    else
      flash[:errors] = @comment.errors.full_messages
      redirect_to @post
    end
  end

  def edit
    @comment = Comment.find(params[:id])
    @post = @comment.post
    check_user_owns_comment
  end

  def update
    @comment = Comment.find(params[:id])
    if params[:flag_button] 
      @comment.is_flagged = true
      @comment.save 
      redirect_to @comment.post
    elsif params[:unflag_button] && @user.is_admin
      @comment.is_flagged = false
      @comment.save
      redirect_to @comment.post
    elsif params[:hide] && @user.is_admin 
      @comment.is_hidden = true
      @comment.is_flagged = false
      @comment.save
      redirect_to @comment.post
    elsif check_user_owns_comment
      @comment.assign_attributes(comment_params)
      @comment.edited = true
      @post = Post.find(comment_params[:post_id])
      if @comment.valid?
        @comment.save
        redirect_to @post
      else
        flash[:errors] = @comment.errors.full_messages
        redirect_to @post
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if check_user_owns_comment
      if @comment
        @post = @comment.post
        @comment.destroy
        redirect_to @post
      else
        flash[:errors] = ["Comment not found"]
        redirect_to launchpad_path
      end
    end
  end


  private

  def comment_params
    params.require(:comment).permit(:user_id,:post_id,:content,:is_fagged,:is_hidden)
  end

  def set_flag_and_hide_and_edit
    @comment.is_flagged = false
    @comment.is_hidden = false
    @comment.edited = false
  end

  def check_user_owns_comment
    if @comment&.user_id != @user_id
      redirect_to launchpad_path
      false
    else
      true
    end
  end
end