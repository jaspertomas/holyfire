class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.boolean :is_admin
      t.boolean :is_encoder
      t.boolean :is_batcher

      t.timestamps
    end
    add_index :users, :name, unique: true 
  end
end
