json.array!(@football_events) do |football_event|
  json.extract! football_event, :id, :event_name, :event_date, :event_time, :team_first, :team_second, :championship
  json.url football_event_url(football_event, format: :json)
end
