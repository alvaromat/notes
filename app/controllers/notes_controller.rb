class NotesController < ApplicationController
  def index
    @note = Note.new
  end

  def create
    @note = Note.create(note_params)
    @note.user=current_user
    if @note.save
      redirect_to index
    else
      render partial: 'shared/errors', locals: {errors: @note.errors}, status: :unprocessable_entity
    end
  end

  before_action :authenticate_user!

  private
  def note_params
    params.require(:note).permit(:title, :body, :color)
  end
end
