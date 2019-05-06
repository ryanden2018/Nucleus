class CreateFriendships < ActiveRecord::Migration[5.2]
  def change
    create_table :friendships do |t|
      t.integer :user_1_id
      t.integer :user_2_id
      t.boolean :accepted

      t.timestamps
    end
  end
end
