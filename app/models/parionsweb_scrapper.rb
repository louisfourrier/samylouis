# Parions Web Scrapper
class ParionswebScrapper
  require 'rubygems'
  require 'nokogiri'
  require 'open-uri'
  require 'uri'

  def self.football_scraper
    generic_football_scraper('https://parionsweb.fdj.fr/paris-football/france')

    generic_football_scraper('https://parionsweb.fdj.fr/paris-football/angleterre')

    generic_football_scraper('https://parionsweb.fdj.fr/paris-football/espagne')

    generic_football_scraper('https://parionsweb.fdj.fr/paris-football/italie')

    generic_football_scraper('https://parionsweb.fdj.fr/paris-football/allemagne')

    generic_football_scraper('https://parionsweb.fdj.fr/paris-football/coupes-deurope')

  end

  def self.generic_football_scraper(url)
    footballurl = url
    platform = 'ParionsWeb'
    # response = Typhoeus.get(football_url, followlocation: true)
    page = Nokogiri::HTML(open(footballurl))
    # Get all the coming days in the page
    coming_days = page.css('#tab_gameevent .event-block')
    # Go through all the days
    coming_days.each do |daycode|
      # Get the Day
      date = daycode.css('.events-date')
      day = date.text.to_s.strip.to_date

      # Get all the Game entries in the Day section
      day_games = daycode.css('.market.market-inline-separate')
      day_games.each do |game_trade|
        # Get the Game Name
        name = game_trade.css('.outcomes.inline-market').text
        # Get the teams name
        teams = name.split('-')
        team_first = teams.first.to_s
        team_second = teams.last.to_s
        # Get Time
        event_time =  game_trade.css('.time').text
        # Get the links
        link = game_trade.css('.outcomes.inline-market a').first
        if !link.blank?
          url = link['href']
        else
          url = nil
        end
        # Get the odds
        odds = game_trade.css('.odds .odd .formatted_price')
        first_ratio = odds[0].text.to_s.gsub(',', '.').to_f
        both_ratio = odds[1].text.to_s.gsub(',', '.').to_f
        second_ratio = odds[2].text.to_s.gsub(',', '.').to_f

        FootballTrade.create(bet_platform_name: platform, bet_platform_url: url, team_first_name: team_first, team_second_name: team_second, event_date: day, event_time: event_time,  first_winning_ratio: first_ratio, both_winning_ratio: both_ratio,
                             second_winning_ratio: second_ratio, last_update: Time.zone.now)

      end
    end
  end

  
end
