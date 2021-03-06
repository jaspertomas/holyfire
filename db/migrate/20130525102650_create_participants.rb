class CreateParticipants < ActiveRecord::Migration
  def change
    create_table :participants do |t|
      t.string :sex
      t.string :fname
      t.string :mname
      t.string :lname
      t.decimal :age
      t.string :occupation
      t.string :introducer
      t.string :guarantor
      t.string :address
      t.string :tel
      t.string :missionary
      t.string :remark
      t.decimal :donation
      t.integer :batch_id
      t.integer :blessing_id
      t.boolean :is_finalized


      t.timestamps
    end
  end
end
