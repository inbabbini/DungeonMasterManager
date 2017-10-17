class CampaignNotesController < ApplicationController
  before_action :set_campaign_note, only: [:show, :edit, :update, :destroy]

  # GET /campaign_notes
  # GET /campaign_notes.json
  def index
    @campaign_notes = CampaignNote.all
  end

  # GET /campaign_notes/1
  # GET /campaign_notes/1.json
  def show
  end

  # GET /campaign_notes/new
  def new
    @campaign_note = CampaignNote.new
  end

  # GET /campaign_notes/1/edit
  def edit
  end

  # POST /campaign_notes
  # POST /campaign_notes.json
  def create
    @campaign_note = CampaignNote.new(campaign_note_params)

    respond_to do |format|
      if @campaign_note.save
        format.html { redirect_to @campaign_note, notice: 'Campaign note was successfully created.' }
        format.json { render :show, status: :created, location: @campaign_note }
      else
        format.html { render :new }
        format.json { render json: @campaign_note.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /campaign_notes/1
  # PATCH/PUT /campaign_notes/1.json
  def update
    respond_to do |format|
      if @campaign_note.update(campaign_note_params)
        format.html { redirect_to @campaign_note, notice: 'Campaign note was successfully updated.' }
        format.json { render :show, status: :ok, location: @campaign_note }
      else
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
      format.html { redirect_to campaign_notes_url, notice: 'Campaign note was successfully destroyed.' }
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
      params.require(:campaign_note).permit(:title, :content, :visible_by_players, :dm_annotation, :text)
    end
end
