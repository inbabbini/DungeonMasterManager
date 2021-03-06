class CharactersController < ApplicationController
  before_action :authenticate
  before_action :set_game
  before_action :set_character, only: [:show, :edit, :update, :destroy, :reassign]
  before_action :user_owns_character_or_game?, only: [:show, :edit, :update, :destroy]
  before_action :user_belongs_to_game?, only: [:new, :create]
  before_action :user_is_dm?, only: :reassign

  # GET /characters
  # GET /characters.json
  def index
    @characters = Character.where(game_id: params[:game_id])
  end

  # GET /characters/1
  # GET /characters/1.json
  def show
    @character = Character.includes([:statuses, :skills, :inventory, :items, :traits, :notes, :achievements]).where(game_id: params[:game_id], id: params[:id]).first
    if user_is_dm?
      @users = @game.players
    end
  end

  # GET /characters/new
  def new
    @character = Character.new
  end

  # GET /characters/1/edit
  def edit
  end

  # POST /characters
  # POST /characters.json
  def create
    @character = Character.new(character_params)
    @character.game = @game
    @character.user = current_user

    respond_to do |format|
      if @character.save
        format.html { redirect_to game_character_path(@game, @character), flash: { success: I18n.t('flash_messages.success.created', model: I18n.t('model.character')) } }
        format.json { render :show, status: :created, location: @character }
      else
        flash.now[:error] = I18n.t('flash_messages.error.form')
        format.html { render :new }
        format.json { render json: @character.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /characters/1
  # PATCH/PUT /characters/1.json
  def update
    respond_to do |format|
      if @character.update(character_params)
        format.html { redirect_to game_character_path(@game, @character), flash: { success: I18n.t('flash_messages.success.updated', model: I18n.t('model.character')) } }
        format.json { render :show, status: :ok, location: @character }
      else
        flash.now[:error] = I18n.t('flash_messages.error.form')
        format.html { render :edit }
        format.json { render json: @character.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /characters/1
  # DELETE /characters/1.json
  def destroy
    @character.destroy
    respond_to do |format|
      format.html { redirect_to game_path(@game), flash: { success: I18n.t('flash_messages.success.destroyed', model: I18n.t('model.character')) } }
      format.json { head :no_content }
    end
  end

  def reassign
    @user = User.find(params[:user_id])
    if @user.nil?
      flash[:error] = "Selected user does not exist"
      redirect_back fallback_location: game_character_path(@game, @character)
    else
      @character.user = @user
      @character.save
      flash[:success] = "Reassigned character %s to user %s" % [@character.name, @user.name]
      redirect_back fallback_location: game_character_path(@game, @character)
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_character
      @character = Character.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def character_params
      params.require(:character).permit(:game_id, :name, :race, :description, :biography, :avatar)
    end
end
