class CategoriesController < ApplicationController
  before_action :authenticate
  before_action :set_game
  before_action :user_owns_game?
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  # GET /categories
  # GET /categories.json
  def index
    @categories = Category.for_game(@game)
    respond_to do |format|
      format.json { render json: @categories, status: :ok }
    end
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
  end

  # GET /categories/new
  def new
    @category= Category.new
  end

  # GET /categories/1/edit
  def edit
  end

  # POST /categories
  # POST /categories.json
  def create
    @category= Category.new(category_params)
    @category.game = @game

    respond_to do |format|
      if @category.save
        format.html { redirect_to game_campaign_notes_path(@game), flash: { success: I18n.t('flash_messages.success.created', model: I18n.t('model.category')) } }
        format.json { render :show, status: :created, location: @category}
      else
        flash.now[:error] = I18n.t('flash_messages.error.form')
        format.html { render :new }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to game_campaign_notes_path(@game), flash: { success: I18n.t('flash_messages.success.updated', model: I18n.t('model.category')) } }
        format.json { render :show, status: :ok, location: @category}
      else
        flash.now[:error] = I18n.t('flash_messages.error.form')
        format.html { render :edit }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @category.destroy
    respond_to do |format|
      format.html { redirect_to game_campaign_notes_path(@game), flash: { success: I18n.t('flash_messages.success.destroyed', model: I18n.t('model.category')) } }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(:game_id, :name)
    end
end
