class CreateCtimes < ActiveRecord::Migration
  def change
    create_table :ctimes do |t|
      t.string :span, limit: 10
      t.string :value, limit: 2

      t.timestamps
    end
  end
end
