class Post < ApplicationRecord
  belongs_to :user

  has_many :comments, dependent: :destroy

  has_many :group_posts
  has_many :groups, through: :group_posts

  has_many :plusses, dependent: :destroy
  has_many :users_liking, class_name: "User", foreign_key: "user_id", through: :plusses

  validates :title, presence: true
  validates :content, presence: true
  validates :content, length: { maximum: 10000 }

  def break_content
    self.content
      .to_s
      .gsub("\r","\n")
      .split("\n")
      .delete_if { |b| b.length == 0 }
  end

  def short_length
    150
  end


  def short_content
    self.content.slice(0,short_length) + ("..." if self.content.length>short_length).to_s
  end

  def plusses_count
    self.plusses.where(is_plus: true).count
  end

  def minusses_count
    self.plusses.where(is_plus:false).count
  end

  def net_plusses
    plusses_count - minusses_count
  end

  def num_comments
    self.comments.count
  end

  def self.posts_for(user)
    # select own posts, friends' posts, groups' posts
    results = []
    results += user.posts.where(is_hidden:false)
    user.friends.each do |friend|
      results += friend.posts.where(is_hidden:false)
    end
    user.groups.each do |group|
      results += group.posts.where(is_hidden:false)
    end

    results.uniq
  end

  def authorized_to_view(other_user)
    unless self.is_private || self.is_hidden
      true
    else
      if other_user == nil
        false
      elsif other_user.is_admin
        !self.is_hidden
      else
        ( (other_user.id == self.user.id) || (Friendship.are_friends(self.user,other_user)) ) && !self.is_hidden
      end
    end
  end

  def self.max_feed_length
    25
  end

  private
end
