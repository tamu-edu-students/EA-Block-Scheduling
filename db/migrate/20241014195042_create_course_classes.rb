class CreateCourseClasses < ActiveRecord::Migration[7.2]
  def change
    create_table :course_classes do |t|
      t.string :course
      t.time :start_time
      t.time :end_time
      t.string :days

      t.timestamps
    end
  end
end
