class Note < ApplicationRecord
  belongs_to :reader
  # belongs_to :book, through: :reader
  belongs_to :book

  # Scopes
  scope :notes_of_reader, -> (reader_id) { where(reader_id: reader_id) }
  scope :notes_of_book_of_reader, -> (book_id, reader_id) { notes_of_reader(reader_id).where(book_id: book_id) }

  # Callbacks
  before_validation :assert_page_number_is_valid
  before_save :generate_keywords

  private
    def generate_keywords
      self.keywords = Carmakart::NgramGenerator.new(description).generate_all_n_grams
    end

    def assert_page_number_is_valid
      begin
        if page_number > book.pages
          self.errors.add(:base, "invalid page number - '#{page_number}'")
          raise ActiveRecord::Rollback
        end
      rescue
      end
    end
end
