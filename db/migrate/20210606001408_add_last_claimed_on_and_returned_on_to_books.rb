class AddLastClaimedOnAndReturnedOnToBooks < ActiveRecord::Migration[6.1]
  def change
    add_column :books, :last_claimed_on, :timestamptz, null: true
    add_column :books, :last_returned_on, :timestamptz, null: true
  end
end
