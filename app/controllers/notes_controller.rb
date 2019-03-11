class NotesController < ApplicationController

  def create
    @note = Note.new(note_params)
    @note.user = current_user
    if @note.save
      flash['notice'] = "Nota salva com sucesso."
    else
      flash['notice'] = "Ocorreu um erro ao salvar a nota. #{@note.errors.full_messages}"
    end
    redirect_to lead_path(@note.lead)
  end

  def destroy
    @note = Note.find(params[:id])
    @lead = @note.lead
    @note.destroy

    redirect_to lead_path(@lead)
  end

  private

  def note_params
    params.require(:note).permit(:description, :lead_id)
  end
end
