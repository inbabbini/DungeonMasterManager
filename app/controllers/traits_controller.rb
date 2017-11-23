class TraitsController < ApplicationController
  before_action :authenticate
  before_action :set_game
  before_action :set_character
  before_action :user_owns_character_or_game?
  before_action :set_trait, only: [:show, :edit, :update, :destroy]


  # GET /characters
  # GET /characters.json
  def index
    @trait = Trait.where(character_id: params[:character_id])
  end

  # GET /characters/1
  # GET /characters/1.json
  def show
  end

  # GET /characters/new
  def new
    @trait = Trait.new
  end

  # GET /characters/1/edit
  def edit
  end

  # POST /characters
  # POST /characters.json
  def create
    @trait = Trait.new(trait_params)
    @trait.character = @character

    respond_to do |format|
      if @trait.save
        format.html { redirect_to game_character_path(@game, @character), flash: { success: I18n.t('flash_messages.success.created', model: I18n.t('model.trait')) } }
        format.json { render :show, trait: :created, location: @trait }
      else
        flash.now[:error] = I18n.t('flash_messages.error.form')
        format.html { render :new }
        format.json { render json: @trait.errors, trait: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /characters/1
  # PATCH/PUT /characters/1.json
  def update
    respond_to do |format|
      if @trait.update(trait_params)
        format.html { redirect_to game_character_path(@game, @character), flash: { success: I18n.t('flash_messages.success.updated', model: I18n.t('model.trait')) } }
        format.json { render :show, trait: :ok, location: @trait }
      else
        flash.now[:error] = I18n.t('flash_messages.error.form')
        format.html { render :edit }
        format.json { render json: @trait.errors, trait: :unprocessable_entity }
      end
    end
  end

  # DELETE /characters/1
  # DELETE /characters/1.json
  def destroy
    @trait.destroy
    respond_to do |format|
      format.html { redirect_to game_character_path(@game, @character), flash: { success: I18n.t('flash_messages.success.destroyed', model: I18n.t('model.trait')) } }
      format.json { head :no_content }
    end
  end

  private
    def set_trait
      @trait = Trait.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def trait_params
      params.require(:trait).permit(:game_id, :character_id, :description)
    end
end
