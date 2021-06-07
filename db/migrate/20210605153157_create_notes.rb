class CreateNotes < ActiveRecord::Migration[6.1]
  def change
    create_table :notes do |t|
      t.integer :page_number, null: false
      t.text :description
      t.string :isbn, limit: 16
      t.text :keywords, array: true, default: []
      t.references :reader
      t.references :book

      t.timestamps
    end
    add_index :notes, :isbn
  end
end
