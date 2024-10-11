class CreateSessions < ActiveRecord::Migration[7.2]
  def change
    create_table :sessions do |t|
      t.string :user_token
      t.text :user_email

      t.timestamps
    end
  end
end
