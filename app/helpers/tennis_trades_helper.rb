# == Schema Information
#
# Table name: tennis_trades
#
#  id                :integer          not null, primary key
#  bet_platform_name :string
#  bet_platform_url  :text
#  team_first_name   :string
#  team_second_name  :string
#  event_date        :date
#  event_time        :string
#  first_ratio       :float
#  second_ratio      :float
#  sport_event_id    :integer
#  last_update       :datetime
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

module TennisTradesHelper
end
