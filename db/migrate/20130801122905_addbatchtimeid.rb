class Addbatchtimeid < ActiveRecord::Migration
  def up
    add_column :batches, :ctime_id, :integer
  end

  def down
  end
end
