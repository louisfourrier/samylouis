# == Schema Information
#
# Table name: sport_event_tradings
#
#  id               :integer          not null, primary key
#  sport_event_id   :integer
#  sport_trade_id   :integer
#  sport_trade_type :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

# Joint Class to associate Sport Event with Sport Trades
class SportEventTrading < ActiveRecord::Base
  belongs_to :sport_event
  belongs_to :sport_trade, polymorphic: true

  validates :sport_event_id, :sport_trade_id, presence: true
  validates :sport_event_id, :uniqueness => {:scope => [:sport_trade_id, :sport_trade_type]}

end
