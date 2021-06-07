class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.string :title, limit: 64, null: false
      t.string :author, limit: 64, null: false
      t.string :isbn, limit: 16, null:false
      t.references :reader, null: false, foreign_key: true

      t.timestamps
    end
    add_index :books, :title, unique: true
    add_index :books, :author
    add_index :books, :isbn, unique: true
  end
end
