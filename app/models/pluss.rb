class PlussValidator < ActiveModel::Validator
  def validate(record)
    if Pluss.find_by(post_id:record.post_id, user_id:record.user_id)
      record.errors.add :base, 'Error adding plus/minus'
    end
  end
end

class Pluss < ApplicationRecord

  belongs_to :post
  belongs_to :user
  validates_with PlussValidator
end
