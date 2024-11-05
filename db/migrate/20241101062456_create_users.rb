class CreateUsers < ActiveRecord::Migration[7.2]  # or the version you are using
  def change
    create_table :users do |t|
      t.string :email
      t.string :first_name
      t.string :last_name
      t.string :uid
      t.string :provider

      t.timestamps
    end

    add_index :users, :email, unique: true
  end
end
