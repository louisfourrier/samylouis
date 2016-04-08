# == Schema Information
#
# Table name: sport_events
#
#  id           :integer          not null, primary key
#  event_name   :string
#  event_date   :date
#  event_time   :string
#  team_first   :string
#  team_second  :string
#  championship :string
#  sport        :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#


# New Class that will become Polymorphic
class SportEvent < ActiveRecord::Base
  include CommonMethod
  has_many :football_trades
  validates :event_name, :event_date, :team_first, :team_second, presence: true
  validates :event_name, uniqueness: { scope: [:team_second, :event_date] }

  before_validation :sanitize_entries

  def self.get_opportunities
    opp = []
    self.find_each do |fe|
      begin
        if fe.inverse_sum < 1
          opp << fe.id
        end
      rescue

      end
    end
    return opp
  end

  def best_first_ratio
    self.football_trades.pluck(:first_winning_ratio).sort.last
  end

  def best_both_ratio
    self.football_trades.pluck(:both_winning_ratio).sort.last
  end

  def best_second_ratio
    self.football_trades.pluck(:second_winning_ratio).sort.last
  end

  def inverse_sum
    sum = 1.0 / self.best_first_ratio + 1.0 / self.best_both_ratio + 1.0 / self.best_second_ratio
    return sum
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
          scope.where('football_events.team_first ILIKE ?',  "%#{term}%")

        when :second_team
          term = I18n.transliterate(value.to_s.strip.downcase).to_s
          scope.where('football_events.team_second ILIKE ?',  "%#{term}%")

        when :event_date
          scope.where('football_events.event_date = ?',  value.to_date)

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
      if event.football_trades.empty?
        event.destroy
      end
    end
  end

  # Clean Event outaddtes
  def self.clean_outdated
    self.find_each do |event|
      if event.event_date < Date.today
        event.destroy
      end
    end
  end

  def sanitize_entries
    unless event_name.blank?
      self.event_name = I18n.transliterate(event_name.to_s.downcase.strip).to_s
    end
    unless team_first.blank?
      self.team_first = I18n.transliterate(team_first.to_s.downcase.strip).to_s
    end
    unless team_second.blank?
      self.team_second = I18n.transliterate(team_second.to_s.downcase.strip).to_s
    end
  end

  def self.create_from_trade(trade)
    e = FootballEvent.new
    e.event_name = trade.team_first_name.to_s + ' - ' + trade.team_second_name.to_s
    e.event_date = trade.event_date
    e.team_first = trade.team_first_name.to_s
    e.team_second = trade.team_second_name.to_s
    e.save
    e
  end


end
