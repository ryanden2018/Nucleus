class UsersController < ApplicationController

  skip_before_action :redirect_if_not_logged_in, only: [:new,:create]

    def show
      @show_user = User.find(params[:id])
      @show_user_posts = @show_user.posts
      if (@user != @show_user) && (!Friendship.are_friends(@user,@show_user))
        redirect_to launchpad_path
      end

      @number_of_pages = (@show_user_posts.length/Post.max_feed_length) + ( @show_user_posts.length%Post.max_feed_length==0 ? 0 : 1 )
      @number_of_pages = ( @number_of_pages == 0 ? 1 : @number_of_pages)
      @page_number = params["page"].to_i
      if @page_number < 1
        @page_number = 1
      end
      if @page_number > @number_of_pages
        @page_number = @number_of_pages
      end

    end

    def new
      @user = User.new
    end

    def create
      @user = User.new(user_params)
      set_default_avatar
      set_admin_false
      if @user.valid?
        @user.save
        session[:user_id] = @user.id
        redirect_to launchpad_path
      else
        flash[:errors] = @user.errors.full_messages
        redirect_to new_user_path
      end
    end

    def edit
      check_auth
    end

    def update
      if check_auth
        @user.assign_attributes(user_params)
        if @user.valid?
          @user.save
          redirect_to launchpad_path
        else
          flash[:errors] = @user.errors.full_messages
          redirect_to edit_user_path(session[:user_id])
        end
      end
    end

    def destroy
      session[:user_id] = nil
      if check_auth
        @user.destroy
        redirect_to new_session_path
      end
    end


    private

    def user_params
      params.require(:user).permit(:username, :password, :password_confirmation, :first_name, :last_name, :age, :email, :bio, :avatar_url)
    end

    def set_default_avatar
      @user.avatar_url = "/assets/Quarkette.png"
    end

    def set_admin_false
      @user.is_admin = false
    end
    
    def check_auth
      if @user_id != params[:id].to_i
        redirect_to launchpad_path
        false
      else
        true
      end
    end
    
end
