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

# Trade of Football
class FootballTrade < ActiveRecord::Base
  include CommonMethod
  belongs_to :football_event
  validates :team_first_name, :team_second_name, :event_date, presence: true
  validates :team_first_name, :uniqueness => {:scope => [:team_second_name, :event_date, :bet_platform_name]}

  before_validation :sanitize_entries
  after_create :check_for_football_event


  def self.create_or_update(params)
    platform = params[:bet_platform_name]
    team_first = params[:team_first_name]
    team_second = params[:team_second_name]
    event_date = params[:event_date]

    puts "Platforme = #{platform}"

    ft = self.where('football_trades.bet_platform_name = ? AND football_trades.team_first_name = ? AND football_trades.team_second_name = ? AND football_trades.event_date = ?', platform, team_first, team_second, event_date).first
    if ft.nil?
      self.create(params)
    else
      puts 'Find an update'
      puts ft.id
      ft.update(params)
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

  def inverse_sum
    return 1.0 / self.first_winning_ratio + 1.0 / self.second_winning_ratio + 1.0 / self.both_winning_ratio
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
          scope.where("football_trades.team_first_name ILIKE ?",  "%#{term}%")

        when :second_team
          term = I18n.transliterate(value.to_s.strip.downcase).to_s
          scope.where("football_trades.team_second_name ILIKE ?",  "%#{term}%")

        when :platform
          term = I18n.transliterate(value.to_s.strip.downcase).to_s
          scope.where("football_trades.bet_platform_name  ILIKE ?",  "%#{term}%")

        when :event_date
          scope.where("football_trades.event_date = ?",  value.to_date)

        when :order # order=field-(ASC|DESC)
          attribute, order = value.split('-')
          scope.order("#{table_name}.#{attribute} #{order}")
        else # unknown key (do nothing or raise error, as you prefer to)
          scope.all
        end

      end
    end
  end

  # Assign or create the Football Event
  def check_for_football_event
    events = FootballEvent.where('football_events.event_date = ? AND football_events.team_first = ? AND football_events.team_second = ?', self.event_date, self.team_first_name, self.team_second_name)
    # Second round to found nearly same events
    if events.empty?
      events = FootballEvent.where('football_events.event_date = ? AND football_events.team_first ILIKE ? AND football_events.team_second ILIKE ?', self.event_date, "%#{self.team_first_name}%", "%#{self.team_second_name}%")
    end
    if events.empty?
      event = FootballEvent.create_from_trade(self)
    else
      event = events.first
    end
      event.football_trades << self
  end

  # Sanitize Fields to have common grounds
  def sanitize_entries
    if !self.team_first_name.blank?
      first_name = I18n.transliterate(self.team_first_name.to_s.downcase.strip).to_s.downcase.strip
      self.team_first_name = SportSanitizer.football_team_sanitizer(first_name)
    end
    if !self.team_second_name.blank?
      second_name = I18n.transliterate(self.team_second_name.to_s.downcase.strip).to_s.downcase.strip
      self.team_second_name = SportSanitizer.football_team_sanitizer(second_name)
    end
    if !self.first_winning_ratio.blank?
      self.first_winning_ratio = self.first_winning_ratio.to_s.gsub(',', '.').to_f
    end
    if !self.both_winning_ratio.blank?
      self.both_winning_ratio = self.both_winning_ratio.to_s.gsub(',', '.').to_f
    end
    if !self.second_winning_ratio.blank?
      self.second_winning_ratio = self.second_winning_ratio.to_s.gsub(',', '.').to_f
    end
  end



end
