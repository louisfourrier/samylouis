# == Schema Information
#
# Table name: football_events
#
#  id           :integer          not null, primary key
#  event_name   :text
#  event_date   :date
#  event_time   :string
#  team_first   :string
#  team_second  :string
#  championship :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class FootballEventsController < ApplicationController
  before_action :set_football_event, only: [:show, :edit, :update, :destroy]

  # GET /football_events
  # GET /football_events.json
  def index
    @football_events = FootballEvent.search_and_paginate(params)
  end

  # GET /football_events/1
  # GET /football_events/1.json
  def show
    @football_trades = @football_event.football_trades.search_and_paginate(params)
  end

  # GET /football_events/new
  def new
    @football_event = FootballEvent.new
  end

  # GET /football_events/1/edit
  def edit
  end

  # POST /football_events
  # POST /football_events.json
  def create
    @football_event = FootballEvent.new(football_event_params)

    respond_to do |format|
      if @football_event.save
        format.html { redirect_to @football_event, notice: 'Football event was successfully created.' }
        format.json { render :show, status: :created, location: @football_event }
      else
        format.html { render :new }
        format.json { render json: @football_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /football_events/1
  # PATCH/PUT /football_events/1.json
  def update
    respond_to do |format|
      if @football_event.update(football_event_params)
        format.html { redirect_to @football_event, notice: 'Football event was successfully updated.' }
        format.json { render :show, status: :ok, location: @football_event }
      else
        format.html { render :edit }
        format.json { render json: @football_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /football_events/1
  # DELETE /football_events/1.json
  def destroy
    @football_event.destroy
    respond_to do |format|
      format.html { redirect_to football_events_url, notice: 'Football event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_football_event
      @football_event = FootballEvent.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def football_event_params
      params.require(:football_event).permit(:event_name, :event_date, :event_time, :team_first, :team_second, :championship)
    end
end
