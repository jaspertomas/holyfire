class Addchinesenametovolunteer < ActiveRecord::Migration
  def up
    add_column :volunteers, :chinesename, :string
  end

  def down
  end
end
