class History < ApplicationRecord
  belongs_to :reader
  belongs_to :book

  # Scopes
  scope :claimed_books, -> { where(status: STATUS::CLAIMED) }
  scope :available_books, -> { where(status: STATUS::AVAILABLE) }

  # Callbacks
  before_create :assert_book_is_free!
  before_validation :claim_book

  after_create_commit :update_book_claimed_status
  after_update_commit :update_book_returned_status

  # Validations
  validates :status, presence: true

  module STATUS
    CLAIMED = 1
    AVAILABLE = 2
  end

  def claimed?
    status == STATUS::CLAIMED
  end

  def available?
    status == STATUS::AVAILABLE
  end

  def return_book!
    update_attribute(:status, STATUS::AVAILABLE)
  end

  def claim_book
    self.status = STATUS::CLAIMED
  end

  private
   def assert_book_is_free!
    if self.class.claimed_books.where(book: book).exists?
      # reader.errors.add(:base, "'#{book.title}' is already claimed")
      self.errors.add(:base, "'#{book.title}' is already claimed")
      raise ActiveRecord::Rollback
    end
   end

   def update_book_returned_status
    history_updated_at = updated_at
    attribute_name = :status
    if saved_change_to_attribute?(attribute_name)
      original_value, saved_value = saved_change_to_attribute(attribute_name)
      if saved_value == STATUS::AVAILABLE
        # product.touch(:started_at, :ended_at) # updates started_at, ended_at and updated_at/on attributes
        book.touch(:last_returned_on, time: history_updated_at)
      end
    end
   end

   def update_book_claimed_status
    history_updated_at = updated_at
    if book.claimed?
      book.touch(:last_claimed_on, time: history_updated_at)
    end
   end
end
