class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password_digest
      t.string :first_name
      t.string :last_name
      t.integer :age
      t.string :email
      t.string :avatar_url
      t.string :bio
      t.boolean :is_admin

      t.timestamps
    end
  end
end
