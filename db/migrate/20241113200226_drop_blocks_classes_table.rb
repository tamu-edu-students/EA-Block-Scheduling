class DropBlocksClassesTable < ActiveRecord::Migration[7.0]
  def up
    drop_table :blocks_classes if table_exists?(:blocks_classes)
  end

  def down
    # Add this if you need to restore the table later
    create_table :blocks_classes do |t|
      t.belongs_to :block
      t.belongs_to :course
      t.timestamps
    end
  end
end
