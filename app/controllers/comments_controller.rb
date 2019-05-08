class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @comment.edited = false
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
  end

  def update
    @comment = Comment.find(params[:id])
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

  def destroy
    @comment = Comment.find(params[:id])
    if @comment
      @post = @comment.post
      @comment.destroy
      redirect_to @post
    else
      flash[:errors] = ["Comment not found"]
      redirect_to launchpad_path
    end
  end


  private

  def comment_params
    params.require(:comment).permit(:user_id,:post_id,:content)
  end
end