class CreateJoinTableBlocksClasses < ActiveRecord::Migration[7.2]
  def change
    create_join_table :blocks, :classes do |t|
      # t.index [:block_id, :class_id]
      # t.index [:class_id, :block_id]
    end
  end
end
