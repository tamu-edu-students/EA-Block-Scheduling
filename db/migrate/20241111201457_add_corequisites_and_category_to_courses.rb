class AddCorequisitesAndCategoryToCourses < ActiveRecord::Migration[7.2]
  def change
    add_column :courses, :corequisites, :string
    add_column :courses, :category, :string
  end
end
