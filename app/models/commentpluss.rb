class CommentplussValidator < ActiveModel::Validator
    def validate(record)
      if Commentpluss.find_by(comment_id:record.comment_id, user_id:record.user_id)
        record.errors.add :base, 'Error adding plus/minus'
      end
    end
  end
  

class Commentpluss < ApplicationRecord
    belongs_to :user
    belongs_to :comment
    validates_with CommentplussValidator
end
