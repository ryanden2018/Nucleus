class PlussesController < ApplicationController


    def create
        find_post
        @post.plusses.build(user_id: session[:user_id], :is_plus => !!params[:is_plus]).save
        redirect_to post_path(@post)
    end



    def destroy
        find_post
        Pluss.find_by(user_id: @user_id, post_id:@post.id)&.destroy
        redirect_to @post
    end

    private

    def find_post
        @post = Post.find(params[:post_id])
    end


    
end
