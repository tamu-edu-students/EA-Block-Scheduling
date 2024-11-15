class CreateStates < ActiveRecord::Migration[7.2]
  def change
    create_table :states do |t|
      t.string :token, null: false
      t.integer :user_id
      t.text :data
      t.datetime :expires_at

      t.timestamps
    end

    add_index :states, :token, unique: true
  end
end
