class NotesController < ApplicationController
  before_action :set_reader_and_book, only: [:new, :create]

  before_action :find_note, only: [:edit, :update, :destroy]

  def new
    @note = @reader.notes.build(book: @book)
    render html: render_to_string({:partial => "shared/notes_modal", :locals => {:note => @note, modal_id: params[:item_id]} }).html_safe
  end

  def create
    begin
      @note = @reader.notes.new({book: @book, **notes_params})
      @note.save!
    rescue ActiveRecord::Rollback, ActiveRecord::RecordInvalid
      # render json:{content: @note.errors.full_messages.join('')}
      render and return
    end
  end

  def edit
    render html: render_to_string({:partial => "edit_note_modal", :locals => {:note => @note, modal_id: params[:id]} }).html_safe
  end

  def update
    @note.attributes= notes_params
    @note.save!
  end

  def destroy
    # binding.pry
    @note.destroy
  end

  private
    def set_reader_and_book
      @reader = Reader.find(params[:reader_id])
      @book = Book.find(params[:book_id])
    end

    def notes_params
      params.require(:note).permit(:page_number, :description)
    end

    def find_note
      @note = Note.find_by(id: params[:id])
    end
end
