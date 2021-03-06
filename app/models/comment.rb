class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many :commentplusses, dependent: :destroy
  has_many :users_liking, class_name: "User", foreign_key: "user_id", through: :commentplusses


  validates :content, presence: true
  validates :content, length: { maximum: 500 }

  def plusses_count
    self.commentplusses.where(is_plus: true).count
  end

  def minusses_count
    self.commentplusses.where(is_plus:false).count
  end

  def net_plusses
    plusses_count - minusses_count
  end

  def authorized_to_view(other_user)
    !self.is_hidden
  end
end
