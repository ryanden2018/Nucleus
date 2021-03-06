class User < ApplicationRecord
  has_secure_password

  has_many :posts, dependent: :destroy

  has_many :comments, dependent: :destroy

  has_many :subscriptions, dependent: :destroy
  has_many :groups, through: :subscriptions
  
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships

  has_many :requests1, class_name: "Request", foreign_key: "sender_id", dependent: :destroy
  has_many :requests2, class_name: "Request", foreign_key: "reciever_id", dependent: :destroy
  has_many :senders, through: :requests2
  has_many :recievers, through: :requests1

  has_many :blocks1, class_name: "Block", foreign_key: "blocker_id", dependent: :destroy
  has_many :blocks2, class_name: "Block", foreign_key: "blockee_id", dependent: :destroy
  has_many :blockers, through: :blocks2
  has_many :blockees, through: :blocks1

  has_many :friendships, class_name: "Friendship", foreign_key: "user_1", dependent: :destroy
  has_many :friends, through: :friendships, source: "user_2"
  has_many :plusses, class_name: "Pluss", dependent: :destroy
  has_many :liked_posts, class_name: "Post", foreign_key: "post_id", through: :plusses
  has_many :commentplusses, class_name: "Commentpluss", dependent: :destroy
  has_many :liked_comments, class_name: "Comment", foreign_key: "comment_id", through: :commentplusses

  validates :username, presence: true
  validates :username, uniqueness: true
  validates :age, presence: true
  validates :age, numericality: { greater_than_or_equal_to: 18 }
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :avatar_url, presence: true

  def full_name
    self.first_name + " " + self.last_name
  end

  def has_blocked?(other_user)
    !!Block.find_by(blocker_id:self.id, blockee_id: other_user.id)
  end

  def user_data
    self.username + " " + self.full_name + " " + self.bio.to_s
  end
end
