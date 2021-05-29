class CreateProductTypes < ActiveRecord::Migration[6.1]
  def change
    create_table :product_types, if_not_exists: true, if_exists: true do |t|
      t.string :name, limit: 64, null: false
      t.text :product_attributes, array: true, default: []

      t.timestamps
    end
    add_index :product_types, :product_attributes, using: :gin
  end
end
