class AddActiveStorageIdToCourses < ActiveRecord::Migration[7.2]
  def change
    add_column :courses, :as_id, :integer
  end
end
