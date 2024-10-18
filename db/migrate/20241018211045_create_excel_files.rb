class CreateExcelFiles < ActiveRecord::Migration[7.2]
  def change
    create_table :excel_files do |t|
      t.string :name

      t.timestamps
    end
  end
end
