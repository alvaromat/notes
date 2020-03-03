class NotesController < ApplicationController
  def index
    @notes = Note.all
    @note = Note.new
  end

  def create
    @note = Note.create(note_params)
    @note.user=current_user
    if @note.save
      render json: @note
    else
      render partial: 'shared/errors', locals: {errors: @note.errors}, status: :unprocessable_entity
    end
  end

  def destroy
    @note = Note.find(params[:id])
    @note.destroy
  end

  before_action :authenticate_user!

  private
  def note_params
    params.require(:note).permit(:title, :body, :color)
  end
end
