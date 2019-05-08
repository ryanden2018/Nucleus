class SubscriptionsController < ApplicationController

    def new
        @subscription = Subscription.new
        @user = User.find(@user_id)
        @groups = Group.all
    end

    def create
        @subscription = Subscription.new(sub_params)
        @subscription.verified = false
        @subscription.save 
        redirect_to launchpad_path
    end

    def destroy
      @subscription = Subscription.find(params[:id])
      check_auth_to_change
      @subscription.destroy
      redirect_to groups_path
    end

    private


    def sub_params
        params.require(:subscription).permit(:group_id, :user_id)
    end

    def check_auth_to_change
        if @subscription.user_id != @user_id
            redirect_to launchpad_path
        end
    end
end
