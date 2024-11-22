class CreatePageRoleAccesses < ActiveRecord::Migration[7.2]
  def change
    create_table :page_role_accesses do |t|
      t.integer :page_id
      t.integer :role_id

      t.timestamps
    end
  end
end
