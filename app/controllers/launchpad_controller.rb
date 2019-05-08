class LaunchpadController < ApplicationController
  def launchpad
    @user = User.find(@user_id)
    @posts = Post.posts_for(@user).sort_by { |p| (-1)*p.created_at.to_i }
    @friend_requesters = @user.senders
  end
end
