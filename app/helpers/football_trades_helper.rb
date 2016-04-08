# == Schema Information
#
# Table name: football_trades
#
#  id                   :integer          not null, primary key
#  football_event_id    :integer
#  bet_platform_name    :string
#  bet_platform_url     :text
#  scrap_code           :text
#  team_first_name      :string
#  team_second_name     :string
#  event_date           :date
#  event_time           :string
#  first_winning_ratio  :float
#  both_winning_ratio   :float
#  second_winning_ratio :float
#  last_update          :datetime
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

module FootballTradesHelper
end
