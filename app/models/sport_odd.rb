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

# Class that describes one Odd associated with a Sport Trade and a Scenario
class SportOdd < ActiveRecord::Base
  include CommonMethod
  # Association
  belongs_to :sport_trade
  # Validations
  validates :name, :value, :sport_trade_id, presence: true
  validates :sport_trade_id, :uniqueness => {:scope => [:name]}
  # Callbacks
  before_validation :sanitize_entries

  # Inverse of the Odd
  def inverse_ratio
    if (value.nil?) || (value == 0)
      return 0
    else
      return 1.0 / self.value
    end
  end

  # Saninitize the odds
  def sanitize_entries
    self.name = self.name.to_s.downcase.strip
    self.value = self.value.to_s.gsub(',', '.').to_f
    if self.value == 0.0
      self.value = 1.0
    end
  end

end
