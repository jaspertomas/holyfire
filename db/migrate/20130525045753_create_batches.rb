class CreateBatches < ActiveRecord::Migration
  def change
    create_table :batches do |t|
      t.string :no
      t.string :gender
      t.integer :blessing_id

      t.timestamps
    end
  end
end
