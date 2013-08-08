class Addchinesedatetoblessing < ActiveRecord::Migration
  def change
    add_column :blessings, :chineseday, :integer
    add_column :blessings, :chinesemonth, :integer
    add_column :blessings, :chineseyear, :integer
  end

end
