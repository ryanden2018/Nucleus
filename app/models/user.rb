class User < ApplicationRecord
  has_secure_password

  has_many :posts

  has_many :subscriptions
  has_many :groups, through: :subscriptions
  
  has_many :friendships
  has_many :friends, through: :friendships

  validates :username, presence: true
  validates :username, uniqueness: true
  validates :age, presence: true
  validates :age, numericality: true
  validates :first_name, presence: true
  validates :last_name, presence: true
end
