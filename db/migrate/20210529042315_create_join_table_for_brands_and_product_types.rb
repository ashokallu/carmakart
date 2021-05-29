class CreateJoinTableForBrandsAndProductTypes < ActiveRecord::Migration[6.1]
  def change
    create_join_table :brands, :product_types do |t|
      t.index [:brand_id, :product_type_id]
      # t.index [:product_type_id, :brand_id]
    end
  end
end
