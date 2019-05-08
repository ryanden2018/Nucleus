class CreateCommentplusses < ActiveRecord::Migration[5.2]
  def change
    create_table :commentplusses do |t|
      t.integer :user_id
      t.integer :comment_id
      t.boolean :is_plus

      t.timestamps
    end
  end
end
