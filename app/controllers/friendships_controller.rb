class FriendshipsController < ApplicationController
    def create
      @friend_request = Request.find_by(sender_id:params["friend_id"],reciever_id:@user_id)
      @friendship1 = Friendship.new(user_1_id:params["friend_id"],user_2_id:@user_id)
      @friendship2 = Friendship.new(user_2_id:params["friend_id"],user_1_id:@user_id)
      if @friend_request && @friendship1.valid? && @friendship2.valid?
        @friendship1.save
        @friendship2.save
        @friend_request.destroy
        flash[:notices] = ["Friend added"]
        redirect_to launchpad_path
      else
        flash[:errors] = ["Friend could not be added"]
        redirect_to launchpad_path
      end
    end

    def index
      @user = User.find(@user_id)
      @friends = @user.friends
      @senders = @user.senders
      @recievers = @user.recievers
      @blockers = @user.blockers
      @not_yet_friends = User.all - ([@user] + @friends + @senders + @recievers + @blockers)

      @search_results = []

      if params["search"] && (params["search"].strip.length > 0)
        @search = params["search"]

        words = params["search"].strip.split(/\s+/)

        @not_yet_friends.each do |fr|
          add_fr = false
          words.each do |word|
            if /\b#{word.downcase}\b/.match(fr.user_data.downcase)
              add_fr = true
            end
            if (word.length>5) && /#{word.downcase}/.match(fr.user_data.downcase)
              add_fr = true
            end
          end
          if add_fr
            @search_results << fr
          end
        end
      end
    end

    def destroy
      @friendship1 = Friendship.find(params[:id])
      @friendship2 = @friendship1&.twin
      if @friendship1 && friendship_includes_user(@friendship1)
        @friendship1.destroy
      end
      if @friendship2 && friendship_includes_user(@friendship2)
        @friendship2.destroy
      end
      redirect_to launchpad_path
    end

    private

    def friendship_includes_user(friendship)
      (friendship.user_1_id == @user_id) || (friendship.user_2_id == @user_id)
    end
    
end
