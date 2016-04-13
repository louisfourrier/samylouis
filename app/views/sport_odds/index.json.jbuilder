json.array!(@sport_odds) do |sport_odd|
  json.extract! sport_odd, :id, :sport_trade_id, :name, :value, :last_update, :description, :scenario_name
  json.url sport_odd_url(sport_odd, format: :json)
end
