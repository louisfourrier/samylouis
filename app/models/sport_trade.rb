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

class SportTrade < ActiveRecord::Base
  include CommonMethod
  # Associations
  belongs_to :sport_event
  has_many :sport_odds, dependent: :destroy

  # Validations
  validates :team_first, :team_second, :event_date, presence: true
  validates :team_first, uniqueness: { scope: [:platform_name, :sport, :team_second, :event_date ]}

  # Callbacks
  before_validation :sanitize_entries
  after_create :check_for_sport_event

  scope :football, -> { where(sport: "football") }
  scope :tennis, -> { where(sport: "tennis") }
  scope :basket, -> { where(sport: "basket") }

  # Method that handles the creation or the update of a sport Trade from the Scrapper
  def self.create_or_update(params)
    platform = params[:platform_name]
    sport = params[:sport]
    if sport.to_s == "football"
      team_first = self.team_sanitization(params[:team_first].to_s)
      team_second = self.team_sanitization(params[:team_second].to_s)
    else
      team_first = self.team_sanitization(params[:team_first].to_s, false)
      team_second = self.team_sanitization(params[:team_second].to_s, false)
    end
    scenario_name = params[:scenario_name]
    event_date = params[:event_date]

    puts params.to_s
    # Try to find a first Sport Trade with the same Characteristic
    st = self.where('sport_trades.platform_name ILIKE ? AND sport_trades.team_first ILIKE ? AND sport_trades.team_second = ? AND sport_trades.event_date = ? AND sport_trades.sport ILIKE ? AND sport_trades.scenario_name ILIKE ?', platform, team_first, team_second, event_date, sport, scenario_name).first

    if st.nil?
      puts "No trades found"
      st = self.create(params)
      return st
    else
      puts 'Find an update'
      puts st.id
      st.update(params)
      return st
    end
  end

  # Add or update Odd
  def add_update_odd(name, value, description)
    odd = self.sport_odds.find_by(name: name)
    if odd.nil?
      odd = self.sport_odds.create(name: name, value: value, description: description, scenario_name: self.scenario_name, last_update: Time.zone.now)
    else
      odd.update(value: value, last_update: Time.zone.now)
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

  # Get the odd with the name name
  def get_odd_with_name(name)
    odd =  self.sport_odds.where('sport_odds.name = ?', name.to_s).first
    if odd
      return odd.value
    else
      return "Not found"
    end
  end

  # Compute the inverse Sum ratio
  def inverse_sum
    sum = 0
    self.sport_odds.each do |odd|
      sum = sum + odd.inverse_ratio
    end
    return sum
  end

  # Search and Pagination Customization
  def self.search_and_paginate(params)
    filter_search(params).paginate(page: params[:page], per_page: 100)
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
          scope.where("sport_trades.team_first ILIKE ?",  "%#{term}%")

        when :second_team
          term = I18n.transliterate(value.to_s.strip.downcase).to_s
          scope.where("sport_trades.team_second ILIKE ?",  "%#{term}%")

        when :platform
          term = I18n.transliterate(value.to_s.strip.downcase).to_s
          scope.where("sport_trades.platform_name  ILIKE ?",  "%#{term}%")

        when :sport
          term = I18n.transliterate(value.to_s.strip.downcase).to_s
          scope.where("sport_trades.sport  ILIKE ?",  "%#{term}%")

        when :event_date
          scope.where("sport_trades.event_date = ?",  value.to_date)

        when :order # order=field-(ASC|DESC)
          attribute, order = value.split('-')
          scope.order("#{table_name}.#{attribute} #{order}")
        else # unknown key (do nothing or raise error, as you prefer to)
          scope.all
        end

      end
    end
  end

  # Assign or create the Sport Event
  def check_for_sport_event
    events = SportEvent.where('sport_events.event_date = ? AND sport_events.team_first = ? AND sport_events.team_second = ? AND sport_events.sport = ? AND sport_events.scenario_name = ?', self.event_date, self.team_first, self.team_second, self.sport, self.scenario_name)
    # Second round to found nearly same events
    if events.empty?
      events = SportEvent.where('sport_events.event_date = ? AND sport_events.team_first ILIKE ? AND sport_events.team_second ILIKE ? AND sport_events.sport = ? AND sport_events.scenario_name = ?', self.event_date, "%#{self.team_first}%", "%#{self.team_second}%", self.sport, self.scenario_name)
    end

    if events.empty?
      event = SportEvent.create_from_sport_trade(self)
    else
      event = events.first
    end

    # Add the Sport Trade to the Sport Event
    event.sport_trades << self
  end

  # Basic Sanitization for the team name
  def self.team_sanitization(name, football = true)
    name = I18n.transliterate(name.to_s.downcase.strip).to_s.downcase.strip
    if football
      name = SportSanitizer.football_team_sanitizer(name)
    end
    name = name.to_s.gsub(' ', '')
    return name
  end

  # Sanitize Fields to have common grounds
  def sanitize_entries
    if !self.team_first.blank?
      if self.sport == "football"
        self.team_first = SportTrade.team_sanitization(self.team_first)
      else
        self.team_first = SportTrade.team_sanitization(self.team_first, false)
      end
    end
    if !self.team_second.blank?
      if self.sport == "football"
        self.team_second = SportTrade.team_sanitization(self.team_second)
      else
        self.team_second = SportTrade.team_sanitization(self.team_second, false)
      end
    end
  end
end
