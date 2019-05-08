class FriendshipValidator < ActiveModel::Validator
  def validate(record)
    if Friendship.find_by(user_1_id:record.user_1_id, user_1_id:record.user_1_id) && Friendship.find_by(user_2_id:record.user_2_id, user_2_id:record.user_2_id)
      record.errors.add :base, 'Error adding user as a friend'
    end
  end
end


class Friendship < ApplicationRecord

  belongs_to :user_1, class_name: "User"
  belongs_to :user_2, class_name: "User"
  validates_with FriendshipValidator
  
  def self.are_friends(user1,user2)
    @friendship1 = Friendship.find_by(user_1_id:user1.id,user_2_id:user2.id)
    @friendship2 = Friendship.find_by(user_2_id:user1.id,user_1_id:user2.id)
    (!!@friendship1) && (!!@friendship2)
  end

  def self.remove_friendship(user1,user2)
    @friendship1 = Friendship.find_by(user_1_id:user1.id,user_2_id:user2.id)
    @friendship2 = Friendship.find_by(user_2_id:user1.id,user_1_id:user2.id)
    @request1 = Request.find_by(sender_id:user1.id,reciever_id:user2.id)
    @request2 = Request.find_by(reciever_id:user1.id,sender_id:user2.id)
    if @friendship1
      @friendship1.destroy
    end
    if @friendship2
      @friendship2.destroy
    end
    if @request1
      @request1.destroy
    end
    if @request2
      @request2.destroy
    end
  end

  def twin
    Friendship.find_by(user_1_id: self.user_2_id, user_2_id: self.user_1_id)
  end
end

