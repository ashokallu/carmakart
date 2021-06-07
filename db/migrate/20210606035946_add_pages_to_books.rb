class AddPagesToBooks < ActiveRecord::Migration[6.1]
  def change
    add_column :books, :pages, :integer, null: true
  end
end
