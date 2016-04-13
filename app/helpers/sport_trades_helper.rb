# == Schema Information
#
# Table name: sport_trades
#
#  id              :integer          not null, primary key
#  sport_event_id  :integer
#  platform_name   :string
#  platform_url    :text
#  sport           :string
#  scenario_choice :integer
#  scenario_name   :string
#  team_first      :string
#  team_second     :string
#  event_name      :string
#  event_date      :date
#  event_time      :string
#  last_update     :datetime
#  inverse_sum     :float
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

module SportTradesHelper
end
