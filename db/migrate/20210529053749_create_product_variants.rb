class CreateProductVariants < ActiveRecord::Migration[6.1]
  def change
    create_table :product_variants do |t|
      t.string :sku_id, limit: 16, null: false
      t.string :name, limit: 128, null: false
      t.jsonb :variant_specific_attributes, null: false, default: '{}'
      t.jsonb :product_specific_attributes, null: false, default: '{}'
      t.references :product, null: false, foreign_key: true
      t.references :product_type, null: false, foreign_key: true

      t.timestamps
    end
    add_index :product_variants, :sku_id, unique: true
    add_index :product_variants, :name
    add_index :product_variants, :variant_specific_attributes, using: :gin
    add_index :product_variants, :product_specific_attributes, using: :gin
  end
end
