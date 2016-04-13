# == Schema Information
#
# Table name: sport_trades
#
#  id              :integer          not null, primary key
#  sport_event_id  :integer
#  platform_name   :string
#  platform_url    :text
#  sport           :string
#  scenario_choice :integer
#  scenario_name   :string
#  team_first      :string
#  team_second     :string
#  event_name      :string
#  event_date      :date
#  event_time      :string
#  last_update     :datetime
#  inverse_sum     :float
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class SportTradesController < ApplicationController
  before_action :set_sport_trade, only: [:show, :edit, :update, :destroy]

  # GET /sport_trades
  # GET /sport_trades.json
  def index
    @sport_trades = SportTrade.search_and_paginate(params)
  end

  # GET /sport_trades/1
  # GET /sport_trades/1.json
  def show
    @sport_odds = @sport_trade.sport_odds.search_and_paginate(params)
  end

  # GET /sport_trades/new
  def new
    @sport_trade = SportTrade.new
  end

  # GET /sport_trades/1/edit
  def edit
  end

  # POST /sport_trades
  # POST /sport_trades.json
  def create
    @sport_trade = SportTrade.new(sport_trade_params)

    respond_to do |format|
      if @sport_trade.save
        format.html { redirect_to @sport_trade, notice: 'Sport trade was successfully created.' }
        format.json { render :show, status: :created, location: @sport_trade }
      else
        format.html { render :new }
        format.json { render json: @sport_trade.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sport_trades/1
  # PATCH/PUT /sport_trades/1.json
  def update
    respond_to do |format|
      if @sport_trade.update(sport_trade_params)
        format.html { redirect_to @sport_trade, notice: 'Sport trade was successfully updated.' }
        format.json { render :show, status: :ok, location: @sport_trade }
      else
        format.html { render :edit }
        format.json { render json: @sport_trade.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sport_trades/1
  # DELETE /sport_trades/1.json
  def destroy
    @sport_trade.destroy
    respond_to do |format|
      format.html { redirect_to sport_trades_url, notice: 'Sport trade was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sport_trade
      @sport_trade = SportTrade.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sport_trade_params
      params.require(:sport_trade).permit(:sport_event_id, :platform_name, :platform_url, :sport, :scenario_choice, :scenario_name, :team_first, :team_second, :event_name, :event_date, :event_time, :last_update, :inverse_sum)
    end
end
