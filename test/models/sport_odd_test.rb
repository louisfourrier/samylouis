# == Schema Information
#
# Table name: sport_odds
#
#  id             :integer          not null, primary key
#  sport_trade_id :integer
#  name           :string
#  value          :float
#  last_update    :datetime
#  description    :text
#  scenario_name  :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'test_helper'

class SportOddTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
