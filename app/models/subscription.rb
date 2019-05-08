class SubscriptionValidator < ActiveModel::Validator
  def validate(record)
    if Subscription.find_by(user_id:record.user_id, group_id:record.group_id)
      record.errors.add :base, 'Error adding subscription'
    end
  end
end


class Subscription < ApplicationRecord
  belongs_to :group
  belongs_to :user

  validates_with SubscriptionValidator
end
