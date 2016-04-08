json.array!(@sport_events) do |sport_event|
  json.extract! sport_event, :id, :event_name, :event_date, :event_time, :team_first, :team_second, :championship, :sport
  json.url sport_event_url(sport_event, format: :json)
end
