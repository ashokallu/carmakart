class CreateBrands < ActiveRecord::Migration[6.1]
  def change
    create_table :brands, if_not_exists: true, if_exists: true do |t|
      t.string :name, limit: 64, null: false

      # t.timestamps
    end
    add_index :brands, :name, unique: true
  end
end
