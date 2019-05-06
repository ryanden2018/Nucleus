class CreatePluses < ActiveRecord::Migration[5.2]
  def change
    create_table :pluses do |t|
      t.integer :post_id
      t.integer :user_id
      t.boolean :is_plus

      t.timestamps
    end
  end
end
