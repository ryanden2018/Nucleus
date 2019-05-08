class Post < ApplicationRecord
  belongs_to :user

  has_many :comments, dependent: :destroy

  has_many :group_posts
  has_many :groups, through: :group_posts

  has_many :plusses, dependent: :destroy
  has_many :users_liking, class_name: "User", foreign_key: "user_id", through: :plusses

  validates :title, presence: true
  validates :content, presence: true

  def break_content
    self.content
      .to_s
      .gsub("\r","\n")
      .split("\n")
      .delete_if { |b| b.length == 0 }
  end

  def short_content
    self.content.slice(0,150) + ("..." if self.content.length>150).to_s
  end

  def net_plusses
    self.plusses.where(is_plus: true).count - self.plusses.where(is_plus:false).count
  end

  def num_comments
    self.comments.count
  end

  def self.posts_for(user)
    # select own posts, friends' posts, groups' posts
    results = []
    results += user.posts
    user.friends.each do |friend|
      results += friend.posts
    end
    user.groups.each do |group|
      results += group.posts
    end

    results.map { |p| p.id }.uniq.map { |id| Post.find(id) }
  end
end
