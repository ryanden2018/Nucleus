class PublicController < ApplicationController

  skip_before_action :redirect_if_not_logged_in, only: [:index]

  def index
    @posts = Post.all.sort_by { |p| (-1)*p.created_at.to_i }
  end
end