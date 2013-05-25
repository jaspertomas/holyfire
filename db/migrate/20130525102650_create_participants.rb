class CreateParticipants < ActiveRecord::Migration
  def change
    create_table :participants do |t|
      t.string :sex
      t.string :name
      t.string :age
      t.string :occupation
      t.string :introducer
      t.string :guarantor
      t.string :address
      t.string :tel
      t.string :missionary
      t.string :remark
      t.string :donation
      t.integer :batch_id
      t.integer :blessing_id

      t.timestamps
    end
  end
end
