class CreateCourses < ActiveRecord::Migration[7.2]
  def change
    create_table :courses do |t|
      t.string :term
      t.text :dept_code
      t.string :course_id
      t.string :sec_coreq_secs
      t.string :syn
      t.string :sec_name
      t.string :short_title
      t.integer :im
      t.string :building
      t.string :room
      t.string :days
      t.time :start_time
      t.time :end_time
      t.string :fac_id
      t.string :faculty_name
      t.integer :crs_capacity
      t.integer :sec_cap
      t.integer :student_count
      t.string :notes

      t.timestamps
    end
  end
end
