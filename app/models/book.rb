class Book < ApplicationRecord
  has_many :histories, dependent: :destroy
  has_many :histories_ordered_by_desc, -> { order(updated_at: :desc) }, class_name: "History", dependent: :destroy
  has_many :readers, through: :histories

  # Validations
  validates_uniqueness_of :isbn, :title

  class << self
    def generate_isbn
      ([*0..9] * 2).shuffle.take(12).unshift(9).join.to_i
    end
  end

  def claimed?
    histories.claimed_books.exists?(book_id: id)
  end

  def available?
    histories.available_books.exists?(book_id: id)
  end

  def total_claims_count
    histories.count
  end
end
