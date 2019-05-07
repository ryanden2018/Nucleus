class User < ApplicationRecord
  has_secure_password

  has_many :posts

  has_many :subscriptions
  has_many :groups, through: :subscriptions
  
  has_many :friendships
  has_many :friends, through: :friendships

  has_many :requests1, class_name: "Request", foreign_key: "sender_id"
  has_many :requests2, class_name: "Request", foreign_key: "reciever_id"
  has_many :senders, through: :requests2
  has_many :recievers, through: :requests1

  has_many :friendships, class_name: "Friendship", foreign_key: "user_1"
  has_many :friends, through: :friendships, source: "user_2"

  validates :username, presence: true
  validates :username, uniqueness: true
  validates :age, presence: true
  validates :age, numericality: true
  validates :first_name, presence: true
  validates :last_name, presence: true

  def full_name
    self.first_name + " " + self.last_name
  end
end
