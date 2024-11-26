class CreateUserRoles < ActiveRecord::Migration[7.2]
  def change
    create_table :user_roles do |t|
      t.integer :user_id
      t.integer :role_id

      t.timestamps
    end
  end
end
