class StatusesController < ApplicationController
  before_action :authenticate
  before_action :set_game
  before_action :set_character
  before_action :user_owns_character_or_game?
  before_action :set_status, only: [:show, :edit, :update, :destroy]

  # GET /characters
  # GET /characters.json
  def index
    @status = Status.where(character_id: params[:character_id])
  end

  # GET /characters/1
  # GET /characters/1.json
  def show
  end

  # GET /characters/new
  def new
    @status = Status.new
  end

  # GET /characters/1/edit
  def edit
  end

  # POST /characters
  # POST /characters.json
  def create
    @status = Status.new(status_params)
    @status.character = @character

    respond_to do |format|
      if @status.save
        format.html { redirect_to game_character_path(@game, @character), flash: { success: I18n.t 'flash_messages.success.created', model: I18n.t 'model.status' } }
        format.json { render :show, status: :created, location: @status }
      else
        flash.now[:error] = I18n.t 'flash_messages.error.form'
        format.html { render :new }
        format.json { render json: @status.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /characters/1
  # PATCH/PUT /characters/1.json
  def update
    respond_to do |format|
      if @status.update(status_params)
        format.html { redirect_to game_character_path(@game, @character), flash: { success: I18n.t 'flash_messages.success.updated', model: I18n.t 'model.status' } }
        format.json { render :show, status: :ok, location: @status }
      else
        flash.now[:error] = I18n.t 'flash_messages.error.form'
        format.html { render :edit }
        format.json { render json: @status.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /characters/1
  # DELETE /characters/1.json
  def destroy
    @status.destroy
    respond_to do |format|
      format.html { redirect_to game_character_path(@game, @character), flash: { success: I18n.t 'flash_messages.success.deleted', model: I18n.t 'model.status' } }
      format.json { head :no_content }
    end
  end

  private
    def set_status
      @status = Status.find(params[:id])
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def status_params
      params.require(:status).permit(:game_id, :character_id, :name, :race, :description, :biography)
    end
end
