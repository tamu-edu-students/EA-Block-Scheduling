class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.text :username
      t.text :password
      t.string :first_name
      t.string :last_name
      t.string :uid
      t.string :email

      t.timestamps
    end
    add_index :users, :username, unique: true
  end
end
