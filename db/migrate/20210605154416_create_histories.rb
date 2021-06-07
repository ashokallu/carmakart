class CreateHistories < ActiveRecord::Migration[6.1]
  def change
    create_table :histories do |t|
      t.references :reader, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true
      t.integer :status, null: false

      t.timestamps
    end
  end
end
