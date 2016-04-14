class GeneralController < ApplicationController
  def home
    @sport_events = SportEvent.where('sport_events.inverse_sum < ?', 1).search_and_paginate(params)
  end
end
