json.array!(@football_trades) do |football_trade|
  json.extract! football_trade, :id, :football_event_id, :bet_platform_name, :bet_platform_url, :scrap_code, :team_first_name, :team_second_name, :event_date, :event_time, :first_winning_ratio, :both_winning_ratio, :second_winning_ratio, :last_update
  json.url football_trade_url(football_trade, format: :json)
end
