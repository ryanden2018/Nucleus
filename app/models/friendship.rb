class Friendship < ApplicationRecord

    belongs_to :user_1, class_name: "User"
    belongs_to :user_2, class_name: "User"
    
    def self.are_friends(user1,user2)
      @friendship1 = Friendship.find_by(user_1_id:user1.id,user_2_id:user2.id)
      @friendship2 = Friendship.find_by(user_2_id:user1.id,user_1_id:user2.id)
      (!!@friendship1) && (!!@friendship2)
    end

    def self.remove_friendships(user1,user2)
      @friendship1 = Friendship.find_by(user_1_id:user1.id,user_2_id:user2.id)
      @friendship2 = Friendship.find_by(user_2_id:user1.id,user_1_id:user2.id)
      @request1 = Request.find_by(sender_id:user1.id,reciever_id:user2.id)
      @request2 = Request.find_by(reciever_id:user1.id,sender_id:user2.id)
    end
end