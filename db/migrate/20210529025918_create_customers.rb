class CreateCustomers < ActiveRecord::Migration[6.1]
  def change
    create_table :customers, if_not_exists: true, if_exists: true do |t|
      t.string :first_name, limit: 64, null: false
      t.string :last_name, limit: 64

      t.timestamps
    end
    add_index :customers, :first_name
    add_index :customers, :last_name
  end
end
