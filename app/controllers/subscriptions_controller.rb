class SubscriptionsController < ApplicationController
   def index

    end

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

    end

    private


    def sub_params
        params.require(:subscription).permit(:group_id, :user_id)
    end

    # t.integer "group_id"
    # t.integer "user_id"
    # t.boolean "verified"
    # t.datetime "created_at", null: false
    # t.datetime "updated_at", null: false
    
end
