class CreateBlessings < ActiveRecord::Migration
  def change
    create_table :blessings do |t|
      t.string :location
      t.date :date
      t.text :contactinfo
      t.text :comments

      t.timestamps
    end
  end
end
