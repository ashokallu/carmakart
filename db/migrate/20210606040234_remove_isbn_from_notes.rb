class RemoveIsbnFromNotes < ActiveRecord::Migration[6.1]
  def change
    remove_column :notes, :isbn, :integer
  end
end
