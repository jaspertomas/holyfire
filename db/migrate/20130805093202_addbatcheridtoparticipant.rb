class Addbatcheridtoparticipant < ActiveRecord::Migration
  def up
    add_column :participants, :batched_by_id, :integer
  end

  def down
  end
end
