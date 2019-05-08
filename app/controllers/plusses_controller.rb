class PlussesController < ApplicationController


    def create
        @post = Post.find(params[:post_id])
        @post.plusses.build(user_id: session[:user_id], :is_plus => !!params[:is_plus]).save
        redirect_to post_path(@post)
    end



    def destroy
        @pluss = Pluss.find(params[:id])
        if check_auth_to_change
            @post = @pluss.post
            @pluss.destroy
            redirect_to @post
        end
    end

    private

    def check_auth_to_change
        if @pluss.user_id != @user_id
            redirect_to launchpad_path
            false
        else
            true
        end
    end
    
end
