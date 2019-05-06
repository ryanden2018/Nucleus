class FriendshipsController < ApplicationController
    before_action :check_login

    def index

    end

    def show

    end

    def create
        # @friendship = current_user.friendships.build(:friend_id => params[:friend_id])
        @friendship = Friendship.new(:user_1_id => session[:user_id], :user_2_id => params[:friend_id])
        @friendship.save
        if @friendship.save
            flash[:notice] = "Friend Added"
            redirect_to new
        else
            flash[:notice] = "Cannot add user as friend"
            redirect_to 
        end
    end

    def destroy

    end

    private


    
end
