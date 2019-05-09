class LaunchpadController < ApplicationController
  def launchpad
    @user = User.find(@user_id)
    @posts = Post.posts_for(@user).sort_by { |p| (-1)*p.created_at.to_i }
    @public_posts = Post.where(is_private: false).sort_by { |p| (-1)*p.created_at.to_i }
    @friend_requesters = @user.senders
    @flagged_posts = Post.where(is_flagged: true).sort_by { |p| (-1)*p.created_at.to_i }
    @flagged_comments = Comment.where(is_flagged: true).sort_by { |p| (-1)*p.created_at.to_i }
  end
end
