# == Schema Information
#
# Table name: sport_odds
#
#  id             :integer          not null, primary key
#  sport_trade_id :integer
#  name           :string
#  value          :float
#  last_update    :datetime
#  description    :text
#  scenario_name  :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class SportOddsController < ApplicationController
  before_action :set_sport_odd, only: [:show, :edit, :update, :destroy]

  # GET /sport_odds
  # GET /sport_odds.json
  def index
    @sport_odds = SportOdd.search_and_paginate(params)
  end

  # GET /sport_odds/1
  # GET /sport_odds/1.json
  def show
  end

  # GET /sport_odds/new
  def new
    @sport_odd = SportOdd.new
  end

  # GET /sport_odds/1/edit
  def edit
  end

  # POST /sport_odds
  # POST /sport_odds.json
  def create
    @sport_odd = SportOdd.new(sport_odd_params)

    respond_to do |format|
      if @sport_odd.save
        format.html { redirect_to @sport_odd, notice: 'Sport odd was successfully created.' }
        format.json { render :show, status: :created, location: @sport_odd }
      else
        format.html { render :new }
        format.json { render json: @sport_odd.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sport_odds/1
  # PATCH/PUT /sport_odds/1.json
  def update
    respond_to do |format|
      if @sport_odd.update(sport_odd_params)
        format.html { redirect_to @sport_odd, notice: 'Sport odd was successfully updated.' }
        format.json { render :show, status: :ok, location: @sport_odd }
      else
        format.html { render :edit }
        format.json { render json: @sport_odd.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sport_odds/1
  # DELETE /sport_odds/1.json
  def destroy
    @sport_odd.destroy
    respond_to do |format|
      format.html { redirect_to sport_odds_url, notice: 'Sport odd was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sport_odd
      @sport_odd = SportOdd.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sport_odd_params
      params.require(:sport_odd).permit(:sport_trade_id, :name, :value, :last_update, :description, :scenario_name)
    end
end
