class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products, if_not_exists: true, if_exists: true do |t|
      t.text :product_name, null: false
      t.text :product_description
      t.references :product_type, null: false, foreign_key: true
      t.references :brand, null: false, foreign_key: true

      t.timestamps
    end
    add_index :products, :product_name
    add_index :products, :product_description
  end
end
