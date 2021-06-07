class BooksController < ApplicationController
  def index
    @books = Book.all
  end

  def show
  end

  def return_book
    book_history = History.find(params[:item_id])
    if book_history.claimed? && book_history.reload.return_book!
      render json: { content: "You have successfully returned this book" }
    else
      render json: {content: "Something went wrong"}
    end
  end
end
