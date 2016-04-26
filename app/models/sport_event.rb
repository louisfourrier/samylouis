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

# New Class that will become Polymorphic
class SportEvent < ActiveRecord::Base
  include CommonMethod
  has_many :sport_trades, dependent: :destroy
  has_many :sport_odds, through: :sport_trades

  validates :event_name, :event_date, :team_first, :team_second, presence: true
  validates :event_name, uniqueness: { scope: [:team_second, :event_date] }

  before_validation :sanitize_entries

  scope :football, -> { where(sport: "football") }
  scope :tennis, -> { where(sport: "tennis") }
  scope :basket, -> { where(sport: "basket") }

  # Get all the names of the odds
  def get_odd_names
    names = self.sport_odds.order('sport_odds.created_at').pluck(:name).uniq
  end

  # Return the bes sport odd for a name
  def best_odd_for(name)
    return self.sport_odds.where('sport_odds.name = ?', name.to_s).order('sport_odds.value desc').first
  end

  # Compute the inverse sum
  def get_inverse_sum
    sum = 0
    self.get_odd_names.each do |name|
      odd_value = self.best_odd_for(name).value
      sum = sum + 1.0 / odd_value
    end
    return sum
  end

  # Compute and save all the inverse sum
  def self.update_inverse_sum
    find_each do |event|
      begin
        event.update_column(:inverse_sum, event.get_inverse_sum)
      rescue
        puts "Erreur dans le calcul de la somme inverse de Sport Event #{event.id}"
      end
    end
  end

 # Email the opportunities
  def self.email_opportunities
    sport_events_opp = self.worth_email_opportunities
    if !sport_events_opp.empty?
      AlertMailer.opportunities(sport_events_opp).deliver
    end
  end

  # MEthod that finds all the sport event that are worth an email. < 1 and Date > today 
  def self.worth_email_opportunities
    today = Date.today
    sport_events_opp = self.where("sport_events.inverse_sum < ? AND sport_events.event_date > ?", 1.0, today)
  end

  # Search Class method
  def self.filter_search(attributes)
    attributes.inject(self) do |scope, (key, value)|
      # return scope.scoped if value.blank?
      if value.blank?
        scope.all
      else
        case key.to_sym

        when :first_team
          term = I18n.transliterate(value.to_s.strip.downcase).to_s
          scope.where('sport_events.team_first ILIKE ?',  "%#{term}%")

        when :second_team
          term = I18n.transliterate(value.to_s.strip.downcase).to_s
          scope.where('sport_events.team_second ILIKE ?',  "%#{term}%")

        when :sport
          term = I18n.transliterate(value.to_s.strip.downcase).to_s
          scope.where('sport_events.sport ILIKE ?',  "%#{term}%")

        when :event_date
          scope.where('sport_events.event_date = ?',  value.to_date)

        when :order # order=field-(ASC|DESC)
          attribute, order = value.split('-')
          scope.order("#{table_name}.#{attribute} #{order}")
        else # unknown key (do nothing or raise error, as you prefer to)
          scope.all
        end

      end
    end
  end

# Clean from database event without trades
  def self.clean_not_linked
    find_each do |event|
      if event.sport_trades.empty?
        event.destroy
      end
    end
  end

  # Clean Event outadated
  def self.clean_outdated
    self.find_each do |event|
      if event.event_date < Date.today
        event.destroy
      end
    end
  end

  # Basic Sanitizing of entries
  def sanitize_entries
    unless event_name.blank?
      self.event_name = I18n.transliterate(event_name.to_s.downcase.strip).to_s.downcase.strip
    end
    unless team_first.blank?
      self.team_first = I18n.transliterate(team_first.to_s.downcase.strip).to_s.downcase.strip.gsub(' ', '')
    end
    unless team_second.blank?
      self.team_second = I18n.transliterate(team_second.to_s.downcase.strip).to_s.downcase.strip.gsub(' ', '')
    end
  end

  # Method that create a Sport Event from a first Sport Trade
  def self.create_from_sport_trade(trade)
    e = SportEvent.new
    e.event_name = trade.team_first.to_s + ' - ' + trade.team_second.to_s
    e.event_date = trade.event_date
    e.team_first = trade.team_first.to_s
    e.team_second = trade.team_second.to_s
    e.sport = trade.sport
    e.scenario_name = trade.scenario_name
    e.save
    e
  end


end
