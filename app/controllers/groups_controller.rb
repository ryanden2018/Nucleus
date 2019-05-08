class GroupsController < ApplicationController
    def index
      @user = User.find(@user_id)
      @groups = @user.groups
    end

    def show
      @group = Group.find(params[:id])
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
      @user = User.find(@user_id)
    end

    def update
      @group = Group.find(params[:id])
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
      @group.destroy
      redirect_to launchpad_path
    end

    private

    def group_params
      params.require(:group).permit(:name,:description,:owner_id)
    end
    
end
