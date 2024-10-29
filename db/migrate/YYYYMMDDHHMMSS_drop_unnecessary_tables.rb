class DropUnnecessaryTables < ActiveRecord::Migration[7.2]
  def up
    drop_table :course_classes if table_exists?(:course_classes)
    drop_table :blocks_classes if table_exists?(:blocks_classes)
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
