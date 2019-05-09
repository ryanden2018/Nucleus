class PublicController < ApplicationController

  skip_before_action :redirect_if_not_logged_in, only: [:index]

  def index
    @posts = Post.where(is_private: false).sort_by { |p| (-1)*p.created_at.to_i }

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
end