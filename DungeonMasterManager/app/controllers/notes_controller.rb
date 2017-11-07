class NotesController < ApplicationController
  before_action :authenticate
  before_action :set_note, only: [:show, :edit, :update, :destroy]
  before_action :set_game
  before_action :set_character
  before_action :user_owns_character_or_game?

  # GET /notes
  # GET /notes.json
  def index
    @notes = Note.all
  end

  # GET /notes/1
  # GET /notes/1.json
  def show
  end

  # GET /notes/new
  def new
    @note = Note.new
  end

  # GET /notes/1/edit
  def edit
  end

  # POST /notes
  # POST /notes.json
  def create
    @note = Note.new(note_params)
    @note.character = @character

    respond_to do |format|
      if @note.save
        format.html { redirect_to game_character_note_path(@game, @character, @note), flash: { success: I18n.t 'flash_messages.success.created', model: I18n.t 'model.note' } }
        format.json { render :show, status: :created, location: @note }
      else
        flash.now[:error] = I18n.t 'flash_messages.error.form'
        format.html { render :new }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /notes/1
  # PATCH/PUT /notes/1.json
  def update
    respond_to do |format|
      if @note.update(note_params)
        format.html { redirect_to game_character_note_path(@game, @character, @note), flash: { success: I18n.t 'flash_messages.success.updated', model: I18n.t 'model.note' } }
        format.json { render :show, status: :ok, location: @note }
      else
        flash.now[:error] = I18n.t 'flash_messages.error.form'
        format.html { render :edit }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notes/1
  # DELETE /notes/1.json
  def destroy
    @note.destroy
    respond_to do |format|
      format.html { redirect_to game_character_path(@game, @character), flash: { success: I18n.t 'flash_messages.success.destroyed', model: I18n.t 'model.note' } }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_note
      @note = Note.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def note_params
      params.require(:note).permit(:game_id, :character_id, :title, :content)
    end
end
