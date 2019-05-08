class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :content, presence: true
end

# t.integer "post_id"
# t.integer "user_id"
# t.string "content"
# t.boolean "edited"
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false