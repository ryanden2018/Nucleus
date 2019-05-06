class Post < ApplicationRecord
  belongs_to :user

  has_many :group_posts
  has_many :groups, through: :group_posts

  validates :title, presence: true
  validates :content, presence: true

  def break_content
    self.content
      .to_s
      .gsub("\r","\n")
      .split("\n")
      .delete_if { |b| b.length == 0 }
  end
end
