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

module SportEventsHelper
end
