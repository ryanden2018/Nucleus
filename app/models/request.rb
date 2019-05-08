class RequestValidator < ActiveModel::Validator
  def validate(record)
    sender_id = record.sender_id
    reciever_id = record.reciever_id

    request1 = Request.find_by(sender_id:sender_id,reciever_id:reciever_id)
    request2 = Request.find_by(reciever_id:sender_id,sender_id:reciever_id)
    block1 = Block.find_by(blocker_id:sender_id,blockee_id:reciever_id)
    block2 = Block.find_by(blockee_id:sender_id,blocker_id:reciever_id)

    if request1 || request2 || block1 || block2
      record.errors.add :base, 'Could not create friend request'
    end
  end
end

class Request < ApplicationRecord
  belongs_to :sender, class_name: "User"
  belongs_to :reciever, class_name: "User"

  validates_with RequestValidator
end

