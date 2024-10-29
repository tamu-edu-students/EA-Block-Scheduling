class DropCoursePrerequisites < ActiveRecord::Migration[7.0]
  def change
    drop_table :course_prerequisites, if_exists: true
  end
end
