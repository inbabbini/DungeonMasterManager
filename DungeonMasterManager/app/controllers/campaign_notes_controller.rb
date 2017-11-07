class CampaignNotesController < ApplicationController
  before_action :authenticate
  before_action :set_game
  before_action :user_belongs_to_game?
  before_action :user_owns_game?, only: [:new, :edit, :create, :update, :destroy, :change_visibility]
  before_action :set_campaign_note, only: [:show, :edit, :update, :destroy, :change_visibility]

  # GET /campaign_notes
  # GET /campaign_notes.json
  def index
    if user_is_dm?
      @categories = Category.includes(:campaign_notes).for_game(@game).order("name DESC")
    else
      @categories = Category.includes(:campaign_notes).where(campaign_notes: {visible_by_players: true}).for_game(@game).order("name DESC")
    end
  end

  # GET /campaign_notes/1
  # GET /campaign_notes/1.json
  def show
  end

  # GET /campaign_notes/new
  def new
    @campaign_note = CampaignNote.new
    @categories = Category.includes(:campaign_notes).for_game(@game).order("name DESC")
  end

  # GET /campaign_notes/1/edit
  def edit
  end

  # POST /campaign_notes
  # POST /campaign_notes.json
  def create
    @campaign_note = CampaignNote.new(campaign_note_params)
    @campaign_note.game = @game

    respond_to do |format|
      if @campaign_note.save
        format.html { redirect_to game_campaign_note_path(@game, @campaign_note), flash: { success: I18n.t 'flash_messages.success.created', model: I18n.t 'model.campaign_note' } }
        format.json { render :show, status: :created, location: @campaign_note }
      else
        flash.now[:error] = I18n.t 'flash_messages.error.form'
        format.html { render :new }
        format.json { render json: @campaign_note.errors, status: :unprocessable_entity }
      end
    end
  end

  def change_visibility
    @campaign_note.visible_by_players = !@campaign_note.visible_by_players

    respond_to do |format|
      if @campaign_note.save
        format.html { redirect_to game_campaign_note_path(@game, @campaign_note), flash: { success: I18n.t 'flash_messages.success.visibility_inverted', model: I18n.t 'model.campaign_note' } }
        format.json { render :show, status: :ok, location: @campaign_note }
      else
        flash[:error] = 'Hmm, there seems to be some problem with this note visibility...'
        format.html { redirect_to @campaign_note }
        format.json { render json: @campaign_note.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /campaign_notes/1
  # PATCH/PUT /campaign_notes/1.json
  def update
    respond_to do |format|
      if @campaign_note.update(campaign_note_params)
        format.html { redirect_to game_campaign_note_path(@game, @campaign_note), flash: { success: I18n.t 'flash_messages.success.updated', model: I18n.t 'model.campaign_note' } }
        format.json { render :show, status: :ok, location: @campaign_note }
      else
        flash.now[:error] = I18n.t 'flash_messages.error.form'
        format.html { render :edit }
        format.json { render json: @campaign_note.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /campaign_notes/1
  # DELETE /campaign_notes/1.json
  def destroy
    @campaign_note.destroy
    respond_to do |format|
      format.html { redirect_to game_campaign_notes_url, flash: { success: I18n.t 'flash_messages.success.destroyed', model: I18n.t 'model.campaign_note' } }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_campaign_note
      @campaign_note = CampaignNote.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def campaign_note_params
      params.require(:campaign_note).permit(:game_id, :category_id, :title, :content, :visible_by_players, :dm_annotation, :document)
    end
end
