json.array!(@tennis_trades) do |tennis_trade|
  json.extract! tennis_trade, :id, :bet_platform_name, :bet_platform_url, :team_first_name, :team_second_name, :event_date, :event_time, :first_ratio, :second_ratio, :sport_event_id, :last_update
  json.url tennis_trade_url(tennis_trade, format: :json)
end
