class GamesController < ApplicationController
  before_action :authenticate
  before_action :set_game, only: [:show, :edit, :update, :destroy]
  before_action :check_visibility_auth, except: [:index, :new, :create]
  before_action :check_edition_auth, only: [:edit, :update, :destroy]

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
        format.html { redirect_to @game, notice: 'Game was successfully created.' }
        format.json { render :show, status: :created, location: @game }
      else
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
        format.html { redirect_to @game, notice: 'Game was successfully updated.' }
        format.json { render :show, status: :ok, location: @game }
      else
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
      format.html { redirect_to games_url, notice: 'Game was successfully destroyed.' }
      format.json { head :no_content }
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

    def check_visibility_auth
      redirect_back fallback_location: games_url, notice: "Non authorized action" unless current_user.is_dm_or_player? @game
    end

    def check_edition_auth
      redirect_back fallback_location: games_url, notice: "Non authorized action" unless current_user.is_owner? @game
    end

    def user_is_dm?
      return current_user == @game.dungeon_master
    end
end
