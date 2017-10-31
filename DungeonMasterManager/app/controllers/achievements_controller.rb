class AchievementsController < ApplicationController
  before_action :authenticate
  before_action :set_game
  before_action :set_character
  before_action :user_owns_character_or_game?
  before_action :set_achievement, only: [:show, :edit, :update, :destroy]

  # GET /achievements
  # GET /achievements.json
  def index
    @achievements = Achievement.where(game: @game, character: @character)
  end

  # GET /achievements/1
  # GET /achievements/1.json
  def show
  end

  # GET /achievements/new
  def new
    @achievement = Achievement.new
  end

  # GET /achievements/1/edit
  def edit
  end

  # POST /achievements
  # POST /achievements.json
  def create
    @achievement = Achievement.new(achievement_params)
    @achievement.character = @character

    respond_to do |format|
      if @achievement.save
        format.html { redirect_to game_character_path(@game, @character), flash: { success: 'Achievement successfully created!' } }
        format.json { render :show, status: :created, location: @achievement }
      else
        flash.now[:error] = 'Hmm, there seems to be some problems with your information...'
        format.html { render :new }
        format.json { render json: @achievement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /achievements/1
  # PATCH/PUT /achievements/1.json
  def update
    respond_to do |format|
      if @achievement.update(achievement_params)
        format.html { redirect_to game_character_path(@game, @character), flash: { success: 'Achievement was successfully updated!' } }
        format.json { render :show, status: :ok, location: @achievement }
      else
        flash[:error] = 'Hmm, there seems to be some problems with your information...'
        format.html { render :edit }
        format.json { render json: @achievement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /achievements/1
  # DELETE /achievements/1.json
  def destroy
    @achievement.destroy
    respond_to do |format|
      format.html { redirect_to game_character_path(@game, @character), flash: { success: 'Achievement was successfully destroyed!' } }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_achievement
      @achievement = Achievement.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def achievement_params
      params.require(:achievement).permit(:game_id, :character_id, :name, :description)
    end
end
