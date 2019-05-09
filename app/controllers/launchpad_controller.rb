class LaunchpadController < ApplicationController
  def launchpad
    @user = User.find(@user_id)
    @posts = Post.posts_for(@user).sort_by { |p| (-1)*p.created_at.to_i }
    @public_posts = Post.where(is_private: false).sort_by { |p| (-1)*p.created_at.to_i }
    @friend_requesters = @user.senders
    @flagged_posts = Post.where(is_flagged: true).sort_by { |p| (-1)*p.created_at.to_i }
    @flagged_comments = Comment.where(is_flagged: true).sort_by { |p| (-1)*p.created_at.to_i }

    @feed_number_of_pages = (@posts.length/Post.max_feed_length) + ( @posts.length%Post.max_feed_length==0 ? 0 : 1 )
    @feed_page_number = params["feed_page"].to_i
    if @feed_page_number < 1
      @feed_page_number = 1
    end
    if @feed_page_number > @feed_number_of_pages
      @feed_page_number = @feed_number_of_pages
    end

    @recents_number_of_pages = (@public_posts.length/Post.max_feed_length) + ( @public_posts.length%Post.max_feed_length==0 ? 0 : 1 )
    @recents_page_number = params["recents_page"].to_i
    if @recents_page_number < 1
      @recents_page_number = 1
    end
    if @recents_page_number > @recents_number_of_pages
      @recents_page_number = @recents_number_of_pages
    end
    
  end
end
