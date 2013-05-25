class CreateBatches < ActiveRecord::Migration
  def change
    create_table :batches do |t|
      t.integer :no
      t.string :gender
      t.integer :blessing_id

      t.timestamps
    end
  end
end
