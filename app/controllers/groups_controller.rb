class GroupsController < ApplicationController
    def index
      @user = User.find(@user_id)
      @groups_owned = Group.groups_owned(@user)
      @other_groups_subscribed_to = Group.other_groups_subscribed_to(@user)
    end

    def show
      @group = Group.find(params[:id])
      @subscription = Subscription.find_by(user_id:@user_id,group_id:@group.id)
      if !@subscription
        flash[:errors] = ["Not subscribed to this group"]
        redirect_to @groups
      end
      @posts = @group.posts.uniq.sort_by { |p| (-1)*p.created_at.to_i }
    end

    def new
      @group = Group.new
      @user = User.find(@user_id)
    end

    def create
      @group = Group.new(group_params)
      if @group.valid?
        @group.save
        Subscription.create(group_id:@group.id,user_id:@group.owner_id,verified:true)
        redirect_to group_path(@group)
      else
        flash[:errors] = @group.errors.full_messages
        redirect_to new_group_path
      end
    end

    def edit
      @group = Group.find(params[:id])
      check_auth_to_change
      @user = User.find(@user_id)
    end

    def update
      @group = Group.find(params[:id])
      check_auth_to_change
      @group.assign_attributes(group_params)
      if @group.valid?
        @group.save
        redirect_to @group
      else
        flash[:errors] = @group.errors.full_messages
        redirect_to edit_group_path(session[:user_id])
      end

    end

    def destroy
      @group = Group.find(params[:id])
      check_auth_to_change
      @group.destroy
      redirect_to launchpad_path
    end

    private

    def group_params
      params.require(:group).permit(:name,:description,:owner_id)
    end

    def check_auth_to_change
      if @group.owner_id != @user_id
        redirect_to launchpad_path
      end
    end
    
end
