class PlussesController < ApplicationController
    def index

    end

    def show

    end

    def new

    end

    def create
        find_post
        @post.plusses.build(user_id: session[:user_id], :is_plus => !!params[:is_plus]).save
        redirect_to post_path(@post)
    end

    def edit

    end

    def update

    end

    private

    def find_post
        @post = Post.find(params[:id])
    end


    
end
