# == Schema Information
#
# Table name: football_trades
#
#  id                   :integer          not null, primary key
#  football_event_id    :integer
#  bet_platform_name    :string
#  bet_platform_url     :text
#  scrap_code           :text
#  team_first_name      :string
#  team_second_name     :string
#  event_date           :date
#  event_time           :string
#  first_winning_ratio  :float
#  both_winning_ratio   :float
#  second_winning_ratio :float
#  last_update          :datetime
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

class FootballTradesController < ApplicationController
  before_action :set_football_trade, only: [:show, :edit, :update, :destroy]

  # GET /football_trades
  # GET /football_trades.json
  def index
    @football_trades = FootballTrade.search_and_paginate(params)
  end

  # GET /football_trades/1
  # GET /football_trades/1.json
  def show
  end

  # GET /football_trades/new
  def new
    @football_trade = FootballTrade.new
  end

  # GET /football_trades/1/edit
  def edit
  end

  # POST /football_trades
  # POST /football_trades.json
  def create
    @football_trade = FootballTrade.new(football_trade_params)

    respond_to do |format|
      if @football_trade.save
        format.html { redirect_to @football_trade, notice: 'Football trade was successfully created.' }
        format.json { render :show, status: :created, location: @football_trade }
      else
        format.html { render :new }
        format.json { render json: @football_trade.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /football_trades/1
  # PATCH/PUT /football_trades/1.json
  def update
    respond_to do |format|
      if @football_trade.update(football_trade_params)
        format.html { redirect_to @football_trade, notice: 'Football trade was successfully updated.' }
        format.json { render :show, status: :ok, location: @football_trade }
      else
        format.html { render :edit }
        format.json { render json: @football_trade.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /football_trades/1
  # DELETE /football_trades/1.json
  def destroy
    @football_trade.destroy
    respond_to do |format|
      format.html { redirect_to football_trades_url, notice: 'Football trade was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_football_trade
      @football_trade = FootballTrade.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def football_trade_params
      params.require(:football_trade).permit(:football_event_id, :bet_platform_name, :bet_platform_url, :scrap_code, :team_first_name, :team_second_name, :event_date, :event_time, :first_winning_ratio, :both_winning_ratio, :second_winning_ratio, :last_update)
    end
end
