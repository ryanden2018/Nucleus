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
      # TODO: implement & make button
    end

    private


    def sub_params
        params.require(:subscription).permit(:group_id, :user_id)
    end
end
