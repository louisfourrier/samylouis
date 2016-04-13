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
#  inverse_sum  :float
#

module FootballEventsHelper
end
