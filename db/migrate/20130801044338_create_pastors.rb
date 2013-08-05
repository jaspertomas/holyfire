class CreatePastors < ActiveRecord::Migration
  def change
    create_table :pastors do |t|
      t.string :name
      t.string :chinesename

      t.timestamps
    end
  end
end
