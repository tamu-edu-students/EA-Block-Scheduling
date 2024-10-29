class AddPrerequisitesToCourses < ActiveRecord::Migration[7.2]
  def change
    add_column :courses, :prerequisites, :string
  end
end
