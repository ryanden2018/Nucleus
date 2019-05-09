class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.integer :post_id
      t.integer :user_id
      t.string :content
      t.boolean :edited
      t.boolean :is_flagged
      t.boolean :is_hidden

      t.timestamps
    end
  end
end
