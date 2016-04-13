json.array!(@sport_trades) do |sport_trade|
  json.extract! sport_trade, :id, :sport_event_id, :platform_name, :platform_url, :sport, :scenario_choice, :scenario_name, :team_first, :team_second, :event_name, :event_date, :event_time, :last_update, :inverse_sum
  json.url sport_trade_url(sport_trade, format: :json)
end
