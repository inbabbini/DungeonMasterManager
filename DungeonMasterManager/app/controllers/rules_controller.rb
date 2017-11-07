class RulesController < ApplicationController
  before_action :authenticate
  before_action :set_game
  before_action :user_belongs_to_game?
  before_action :user_owns_game?, only: [:new, :edit, :create, :update, :destroy]
  before_action :set_rule, only: [:show, :edit, :update, :destroy]

  # GET /rules
  # GET /rules.json
  def index
    @rules = Rule.where(game: @game)
  end

  # GET /rules/1
  # GET /rules/1.json
  def show
  end

  # GET /rules/new
  def new
    @rule = Rule.new
  end

  # GET /rules/1/edit
  def edit
  end

  # POST /rules
  # POST /rules.json
  def create
    @rule = Rule.new(rule_params)
    @rule.game = @game

    respond_to do |format|
      if @rule.save
        format.html { redirect_to game_rules_path(@game), flash: { success: I18n.t 'flash_messages.success.created', model: I18n.t 'model.rule' } }
        format.json { render :show, status: :created, location: @rule }
      else
        flash.now[:error] = I18n.t 'flash_messages.error.form'
        format.html { render :new }
        format.json { render json: @rule.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rules/1
  # PATCH/PUT /rules/1.json
  def update
    respond_to do |format|
      if @rule.update(rule_params)
        format.html { redirect_to game_rules_path(@game), flash: { success: I18n.t 'flash_messages.success.updated', model: I18n.t 'model.rule' } }
        format.json { render :show, status: :ok, location: @rule }
      else
        flash.now[:error] = I18n.t 'flash_messages.error.form'
        format.html { render :edit }
        format.json { render json: @rule.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rules/1
  # DELETE /rules/1.json
  def destroy
    @rule.destroy
    respond_to do |format|
      format.html { redirect_to game_rules_path(@game), flash: { success: I18n.t 'flash_messages.success.destroyed', model: I18n.t 'model.rule' } }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rule
      @rule = Rule.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rule_params
      params.require(:rule).permit(:description)
    end
end
