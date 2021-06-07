class Reader < ApplicationRecord
  has_many :histories
  has_many :histories_in_descending_order, -> () { order(updated_at: :desc) }, class_name: "History"
  has_many :books, through: :histories_in_descending_order

  has_many :notes

  def notes_for_book(book_id)
    notes.where(book: book_id)
  end
end
