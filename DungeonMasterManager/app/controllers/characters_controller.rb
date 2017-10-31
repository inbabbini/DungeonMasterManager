class CharactersController < ApplicationController
  before_action :authenticate
  before_action :set_game
  before_action :user_owns_character_or_game?, only: [:show, :edit, :update, :destroy]
  before_action :user_belongs_to_game?, only: [:new, :create]
  before_action :set_character, only: [:show, :edit, :update, :destroy]

  # GET /characters
  # GET /characters.json
  def index
    @characters = Character.where(game_id: params[:game_id])
  end

  # GET /characters/1
  # GET /characters/1.json
  def show
    @character = Character.includes([:statuses, :skills, :inventory, :items, :traits, :notes, :achievements]).where(game_id: params[:game_id], id: params[:id]).first
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
        format.html { redirect_to game_character_path(@game, @character), flash: { success: 'Character was successfully created!' } }
        format.json { render :show, status: :created, location: @character }
      else
        flash[:error] = 'Hmm, there seems to be some errors with your information...'
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
        format.html { redirect_to game_character_path(@game, @character), flash: { success: 'Character was successfully updated!' } }
        format.json { render :show, status: :ok, location: @character }
      else
        flash[:error] = 'Hmm, there seems to be some errors with your information...'
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
      format.html { redirect_to game_path(@game), flash: { success: 'Character was successfully deleted!' } }
      format.json { head :no_content }
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
