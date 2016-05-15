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

class TennisTrade < ActiveRecord::Base
  has_many :sport_event_tradings, as: :sport_trade, dependent: :destroy
  has_many :sport_events, through: :sport_event_tradings

  include CommonMethod

  validates :team_first_name, :team_second_name, :event_date, presence: true
  validates :team_first_name, :uniqueness => {:scope => [:team_second_name, :event_date, :bet_platform_name]}

  before_validation :sanitize_entries
  after_create :check_for_sport_event

  SPORT = "tennis"

  # Return the name of the Sport
  def sport
    return SPORT.to_s
  end

  def sport_event
    self.sport_events.first
  end

  # Assign or create the Football Event
  def check_for_sport_event
    events = SportEvent.where('sport_events.event_date = ? AND sport_events.team_first ILIKE ? AND sport_events.team_second ILIKE ? AND sport_events.sport = ?', self.event_date, "%#{self.team_first_name}%", "%#{self.team_second_name}%", SPORT)
    if events.empty?
      event = SportEvent.create_from_trade(self)
    else
      event = events.first
    end
      self.sport_events << event
  end

  # Sanitize Fields to have common grounds
  def sanitize_entries
    if !self.team_first_name.blank?
      first_name = I18n.transliterate(self.team_first_name.to_s.downcase.strip).to_s.downcase.strip
      self.team_first_name = first_name
    end
    if !self.team_second_name.blank?
      second_name = I18n.transliterate(self.team_second_name.to_s.downcase.strip).to_s.downcase.strip
      self.team_second_name = second_name
    end
    if !self.first_ratio.blank?
      self.first_ratio = self.first_ratio.to_s.gsub(',', '.').to_f
    end

    if !self.second_ratio.blank?
      self.second_ratio = self.second_ratio.to_s.gsub(',', '.').to_f
    end
  end

end
