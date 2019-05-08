class CommentplussesController < ApplicationController
    def create
        @comment = Comment.find(params[:comment_id])
        @comment.commentplusses.build(user_id: session[:user_id], :is_plus => !!params[:is_plus]).save
        redirect_to post_path(@comment.post)
    end



    def destroy
        @commentpluss = Commentpluss.find(params[:id])
        if check_auth_to_change
            @post = @commentpluss.comment.post
            @commentpluss.destroy
            redirect_to @post
        end
    end

    private

    def check_auth_to_change
        if @commentpluss.user_id != @user_id
            redirect_to launchpad_path
            false
        else 
            true
        end
    end
    
end
