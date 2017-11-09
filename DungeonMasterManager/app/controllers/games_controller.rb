class GamesController < ApplicationController
  before_action :authenticate
  before_action :set_game, only: [:show, :edit, :update, :destroy]

  # GET /games
  # GET /games.json
  def index
    @played_games = current_user.played_games
    @mastered_games = current_user.mastered_games
  end

  # GET /games/1
  # GET /games/1.json
  def show
    if user_is_dm?
      @categories = Category.includes(:campaign_notes).where(game: @game).order("name DESC")
      @characters = Character.where(game: @game)
    else
      @categories = Category.includes(:campaign_notes).where(campaign_notes: {visible_by_players: true}).for_game(@game).order("name DESC")
      @characters = Character.where(game: @game, user: current_user)
    end
    @rules = Rule.where(game: @game)
  end

  # GET /games/new
  def new
    @game = Game.new
  end

  # GET /games/1/edit
  def edit
  end

  # POST /games
  # POST /games.json
  def create
    @game = Game.new(game_params)
    @game.dungeon_master = current_user

    respond_to do |format|
      if @game.save
        format.html { redirect_to @game, flash: { success: I18n.t('flash_messages.success.created', model: I18n.t('model.game')) } }
        format.json { render :show, status: :created, location: @game }
      else
        flash.now[:error] = I18n.t('flash_messages.error.form')
        format.html { render :new }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /games/1
  # PATCH/PUT /games/1.json
  def update
    respond_to do |format|
      if @game.update(game_params)
        format.html { redirect_to @game, flash: { success: I18n.t('flash_messages.success.updated', model: I18n.t('model.game')) } }
        format.json { render :show, status: :ok, location: @game }
      else
        flash.now[:error] = I18n.t('flash_messages.error.form')
        format.html { render :edit }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    @game.destroy
    respond_to do |format|
      format.html { redirect_to games_url, flash: { success: I18n.t('flash_messages.success.destroyed', model: I18n.t('model.game')) } }
      format.json { head :no_content }
    end
  end

  def join
  end

  def register
    @game = Game.where(secret_key: game_params[:secret_key]).first
    if !@game.nil?
      @registered, @message = @game.add_player current_user
    else
      @registered = false
      @message = I18n.t('flash_messages.error.invalid_game_key')
    end

    respond_to do |format|
      if @registered
        format.html { redirect_to game_path(@game), flash: { success: @message } }
        format.json { render :show, status: :ok, location: @game }
      else
        format.html { redirect_to games_join_path, flash: { error: @message } }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def game_params
      params.require(:game).permit(:secret_key, :name)
    end

end
