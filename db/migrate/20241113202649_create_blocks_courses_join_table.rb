class CreateBlocksCoursesJoinTable < ActiveRecord::Migration[7.0]
  def change
    create_table :blocks_courses, id: false do |t|
      t.belongs_to :block, null: false
      t.belongs_to :course, null: false
      t.index [:block_id, :course_id]
      t.index [:course_id, :block_id]
    end
  end
end
