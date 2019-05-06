class UsersController < ApplicationController
    before_action :check_login

    def index
      @posts = Post.all
      @users = User.all
    end

    def show

    end

    def new

    end

    def create

    end

    def edit

    end

    def update

    end

    def destroy

    end


    private


    
    
end
