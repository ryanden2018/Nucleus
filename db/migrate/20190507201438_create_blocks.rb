class CreateBlocks < ActiveRecord::Migration[5.2]
  def change
    create_table :blocks do |t|
      t.integer :blocker_id
      t.integer :blockee_id

      t.timestamps
    end
  end
end
