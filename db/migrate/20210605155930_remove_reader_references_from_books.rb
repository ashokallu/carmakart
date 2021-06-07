class RemoveReaderReferencesFromBooks < ActiveRecord::Migration[6.1]
  def change
    remove_reference :books, :reader, null: false, foreign_key: true
  end
end
