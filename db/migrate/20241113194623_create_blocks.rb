class CreateBlocks < ActiveRecord::Migration[7.0]
  def change
    create_table :blocks do |t|
      t.timestamps
    end

    create_table :blocks_courses, id: false do |t|
      t.belongs_to :block
      t.belongs_to :course
    end
  end
end
