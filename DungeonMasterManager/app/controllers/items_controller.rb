class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :set_game
  before_action :set_character
  before_action :user_owns_character_or_game?

  # GET /items
  # GET /items.json
  def index
    @items = Item.all
  end

  # GET /items/1
  # GET /items/1.json
  def show
  end

  # GET /items/new
  def new
    @item = Item.new
  end

  # GET /items/1/edit
  def edit
  end

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(item_params)
    @item.inventory = @character.inventory

    respond_to do |format|
      if @item.save
        format.html { redirect_to game_character_path(@game, @character), flash: { success: 'Item was successfully created!' } }
        format.json { render :show, status: :created, location: @item }
      else
        flash[:error] = 'Hmm, there seems to be some errors with your information...'
        format.html { render :new }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to game_character_path(@game, @character), flash: { success: 'Item was successfully update!' } }
        format.json { render :show, status: :ok, location: @item }
      else
        flash[:error] = 'Hmm, there seems to be some errors with your information...'
        format.html { render :edit }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item.destroy
    respond_to do |format|
      format.html { redirect_to game_character_path(@game, @character), flash: { success: 'Item was successfully deleted!' } }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:game_id, :character_id, :name, :description, :quantity)
    end
end
