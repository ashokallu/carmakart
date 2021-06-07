class ReadersController < ApplicationController
  before_action :set_reader, only: [:show]

  def index
  end

  def show
    @histories = @reader.histories_in_descending_order.includes(:book)
  end

  def books
    render template: "books/index"
  end

  private
    def set_reader
      @reader = Reader.find_by(id: params[:id])
    end
end
