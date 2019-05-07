class Group < ApplicationRecord

  has_many :group_posts, dependent: :destroy
  has_many :posts, through: :group_posts

  has_many :subscriptions, dependent: :destroy
  has_many :users, through: :subscriptions

  validates :name, presence: true
  validates :name, uniqueness: true
  validates :description, presence: true

end
