class PlussesController < ApplicationController


    def create
        @post = Post.find(params[:post_id])
        @post.plusses.build(user_id: session[:user_id], :is_plus => !!params[:is_plus]).save
        redirect_to post_path(@post)
    end



    def destroy
        @pluss = Pluss.find(params[:id])
        @post = @pluss.post
        @pluss.destroy
        redirect_to @post
    end


    
end
