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
        redirect_to groups_path
      end
      @posts = @group.posts.uniq.sort_by { |p| (-1)*p.created_at.to_i }

      @recents_number_of_pages = (@posts.length/Post.max_feed_length) + ( @posts.length%Post.max_feed_length==0 ? 0 : 1 )
      @recents_number_of_pages = ( @recents_number_of_pages == 0 ? 1 : @recents_number_of_pages)
      @recents_page_number = params["recents_page"].to_i
      if @recents_page_number < 1
        @recents_page_number = 1
      end
      if @recents_page_number > @recents_number_of_pages
        @recents_page_number = @recents_number_of_pages
      end
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
    end

    def update
      @group = Group.find(params[:id])
      if check_auth_to_change
        @group.assign_attributes(group_params)
        if @group.valid?
          @group.save
          redirect_to @group
        else
          flash[:errors] = @group.errors.full_messages
          redirect_to edit_group_path(session[:user_id])
        end
      end
    end

    def destroy
      @group = Group.find(params[:id])
      if check_auth_to_change
        @group.destroy
        redirect_to launchpad_path
      end
    end

    private

    def group_params
      params.require(:group).permit(:name,:description,:owner_id)
    end

    def check_auth_to_change
      if @group.owner_id != @user_id
        redirect_to launchpad_path
        false
      else
        true
      end
    end
    
end
