class BlockValidator < ActiveModel::Validator
  def validate(record)
    blocker_id = record.blocker_id
    blockee_id = record.blockee_id

    block1 = Block.find_by(blocker_id:blocker_id,blockee_id:blockee_id)
    block2 = Block.find_by(blockee_id:blocker_id,blocker_id:blockee_id)

    if block1 || block2
      record.errors.add :base, 'Could not block user'
    end
  end
end

class Block < ApplicationRecord
  belongs_to :blocker, class_name: "User"
  belongs_to :blockee, class_name: "User"

  validates_with BlockValidator
end
