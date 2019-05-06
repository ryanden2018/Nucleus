class CreateGroupPosts < ActiveRecord::Migration[5.2]
  def change
    create_table :group_posts do |t|
      t.integer :group_id
      t.integer :post_id

      t.timestamps
    end
  end
end
