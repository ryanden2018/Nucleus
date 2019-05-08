class Group < ApplicationRecord

  has_many :group_posts, dependent: :destroy
  has_many :posts, through: :group_posts

  has_many :subscriptions, dependent: :destroy
  has_many :users, through: :subscriptions

  validates :name, presence: true
  validates :name, uniqueness: true
  validates :description, presence: true


  def self.groups_owned(user)
    groups = user.groups
    groups.select do |group|
      group.owner_id == user.id
    end.uniq
  end

  def self.other_groups_subscribed_to(user)
    groups = user.groups
    groups.select do |group|
      group.owner_id != user.id
    end.uniq
  end

end
