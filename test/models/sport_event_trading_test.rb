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

require 'test_helper'

class SportEventTradingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
