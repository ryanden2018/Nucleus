class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.string :title
      t.string :image_url
      t.string :content
      t.boolean :edited
      t.boolean :private

      t.timestamps
    end
  end
end
