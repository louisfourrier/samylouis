# == Schema Information
#
# Table name: sport_events
#
#  id              :integer          not null, primary key
#  event_name      :string
#  event_date      :date
#  event_time      :string
#  team_first      :string
#  team_second     :string
#  championship    :string
#  sport           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  inverse_sum     :float
#  scenario_choice :integer
#  scenario_name   :string
#

class SportEventsController < ApplicationController
  before_action :set_sport_event, only: [:show, :edit, :update, :destroy]

  # GET /sport_events
  # GET /sport_events.json
  def index
    @sport_events = SportEvent.search_and_paginate(params)
  end

  # GET /sport_events/1
  # GET /sport_events/1.json
  def show
    @sport_trades = @sport_event.sport_trades
  end

  # GET /sport_events/new
  def new
    @sport_event = SportEvent.new
  end

  # GET /sport_events/1/edit
  def edit
  end

  # POST /sport_events
  # POST /sport_events.json
  def create
    @sport_event = SportEvent.new(sport_event_params)

    respond_to do |format|
      if @sport_event.save
        format.html { redirect_to @sport_event, notice: 'Sport event was successfully created.' }
        format.json { render :show, status: :created, location: @sport_event }
      else
        format.html { render :new }
        format.json { render json: @sport_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sport_events/1
  # PATCH/PUT /sport_events/1.json
  def update
    respond_to do |format|
      if @sport_event.update(sport_event_params)
        format.html { redirect_to @sport_event, notice: 'Sport event was successfully updated.' }
        format.json { render :show, status: :ok, location: @sport_event }
      else
        format.html { render :edit }
        format.json { render json: @sport_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sport_events/1
  # DELETE /sport_events/1.json
  def destroy
    @sport_event.destroy
    respond_to do |format|
      format.html { redirect_to sport_events_url, notice: 'Sport event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sport_event
      @sport_event = SportEvent.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sport_event_params
      params.require(:sport_event).permit(:event_name, :event_date, :event_time, :team_first, :team_second, :championship, :sport)
    end
end
