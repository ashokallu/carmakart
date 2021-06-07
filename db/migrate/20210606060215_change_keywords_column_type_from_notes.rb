class ChangeKeywordsColumnTypeFromNotes < ActiveRecord::Migration[6.1]
  def change
    change_table :notes do |t|
      t.remove :keywords
      t.column :keywords, :jsonb, default: '{}'
      t.index :keywords, using: :gin
    end
  end
end
