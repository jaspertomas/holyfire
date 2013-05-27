class AddCreatedByToParticipants < ActiveRecord::Migration
  def change
    add_column :participants, :created_by_id, :integer
    add_column :participants, :updated_by_id, :integer
  end
end
