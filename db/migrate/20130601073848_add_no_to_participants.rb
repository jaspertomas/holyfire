class AddNoToParticipants < ActiveRecord::Migration
  def change
    add_column :participants, :no, :integer
  end
end
