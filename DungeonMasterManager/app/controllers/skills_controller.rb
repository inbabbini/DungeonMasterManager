class SkillsController < ApplicationController
  before_action :authenticate
  before_action :set_game
  before_action :set_character
  before_action :user_owns_character_or_game?
  before_action :set_skill, only: [:show, :edit, :update, :destroy]

  # GET /skills
  # GET /skills.json
  def index
    @skills = Skill.all
  end

  # GET /skills/1
  # GET /skills/1.json
  def show
  end

  # GET /skills/new
  def new
    @skill = Skill.new
  end

  # GET /skills/1/edit
  def edit
  end

  # POST /skills
  # POST /skills.json
  def create
    @skill = Skill.new(skill_params)
    @skill.character = @character

    respond_to do |format|
      if @skill.save
        format.html { redirect_to game_character_path(@game, @character), flash: { success: 'Skill was successfully created!' } }
        format.json { render :show, status: :created, location: @skill }
      else
        flash[:error] = 'Hmm, there seems to be some errors with your information...'
        format.html { render :new }
        format.json { render json: @skill.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /skills/1
  # PATCH/PUT /skills/1.json
  def update
    respond_to do |format|
      if @skill.update(skill_params)
        format.html { redirect_to game_character_path(@game, @character), flash: { success: 'Skill was successfully updated!' } }
        format.json { render :show, status: :ok, location: @skill }
      else
        flash[:error] = 'Hmm, there seems to be some errors with your information...'
        format.html { render :edit }
        format.json { render json: @skill.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /skills/1
  # DELETE /skills/1.json
  def destroy
    @skill.destroy
    respond_to do |format|
      format.html { redirect_to skills_url, flash: { success: 'Skill was successfully destroy!' } }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_skill
      @skill = Skill.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def skill_params
      params.require(:skill).permit(:game_id, :character_id, :name, :description)
    end
end
