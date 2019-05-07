class LaunchpadController < ApplicationController
  def launchpad
    @user = User.find(@user_id)
    @posts = Post.all
    @friend_requesters = @user.senders
  end
end
