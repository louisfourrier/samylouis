# == Schema Information
#
# Table name: tennis_trades
#
#  id                :integer          not null, primary key
#  bet_platform_name :string
#  bet_platform_url  :text
#  team_first_name   :string
#  team_second_name  :string
#  event_date        :date
#  event_time        :string
#  first_ratio       :float
#  second_ratio      :float
#  sport_event_id    :integer
#  last_update       :datetime
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class TennisTradesController < ApplicationController
  before_action :set_tennis_trade, only: [:show, :edit, :update, :destroy]

  # GET /tennis_trades
  # GET /tennis_trades.json
  def index
    @tennis_trades = TennisTrade.all
  end

  # GET /tennis_trades/1
  # GET /tennis_trades/1.json
  def show
  end

  # GET /tennis_trades/new
  def new
    @tennis_trade = TennisTrade.new
  end

  # GET /tennis_trades/1/edit
  def edit
  end

  # POST /tennis_trades
  # POST /tennis_trades.json
  def create
    @tennis_trade = TennisTrade.new(tennis_trade_params)

    respond_to do |format|
      if @tennis_trade.save
        format.html { redirect_to @tennis_trade, notice: 'Tennis trade was successfully created.' }
        format.json { render :show, status: :created, location: @tennis_trade }
      else
        format.html { render :new }
        format.json { render json: @tennis_trade.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tennis_trades/1
  # PATCH/PUT /tennis_trades/1.json
  def update
    respond_to do |format|
      if @tennis_trade.update(tennis_trade_params)
        format.html { redirect_to @tennis_trade, notice: 'Tennis trade was successfully updated.' }
        format.json { render :show, status: :ok, location: @tennis_trade }
      else
        format.html { render :edit }
        format.json { render json: @tennis_trade.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tennis_trades/1
  # DELETE /tennis_trades/1.json
  def destroy
    @tennis_trade.destroy
    respond_to do |format|
      format.html { redirect_to tennis_trades_url, notice: 'Tennis trade was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tennis_trade
      @tennis_trade = TennisTrade.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tennis_trade_params
      params.require(:tennis_trade).permit(:bet_platform_name, :bet_platform_url, :team_first_name, :team_second_name, :event_date, :event_time, :first_ratio, :second_ratio, :sport_event_id, :last_update)
    end
end
