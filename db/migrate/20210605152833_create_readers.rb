class CreateReaders < ActiveRecord::Migration[6.1]
  def change
    create_table :readers do |t|
      t.string :first_name, limit: 64, null: false
      t.string :last_name, limit: 64, null: false
      t.integer :age, null: false
      t.string :email, limit: 64, null: false

      t.timestamps
    end
    add_index :readers, :first_name
    add_index :readers, :last_name
  end
end
