
# Betclic Scraper
class BetclicScrapper
  require 'rubygems'
  require 'nokogiri'
  require 'open-uri'
  require 'uri'

  # Get all the links corresponding to each league
  def self.football_scraper
    self.football_generic_scraper("https://www.betclic.fr/football/ligue-1-e4")
    self.football_generic_scraper("https://www.betclic.fr/football/ligue-2-e19")
    self.football_generic_scraper("https://www.betclic.fr/football/ligue-des-champions-e8")
    self.football_generic_scraper("https://www.betclic.fr/football/europa-league-e3453")
    self.football_generic_scraper("https://www.betclic.fr/football/angl-premier-league-e3")
    self.football_generic_scraper("https://www.betclic.fr/football/angl-championship-e28")
    self.football_generic_scraper("https://www.betclic.fr/football/espagne-liga-primera-e7")
    self.football_generic_scraper("https://www.betclic.fr/football/espagne-liga-segunda-e31")
    self.football_generic_scraper("https://www.betclic.fr/football/espagne-coupe-du-roi-e47")
    self.football_generic_scraper("https://www.betclic.fr/football/italie-serie-a-e6")
    self.football_generic_scraper("https://www.betclic.fr/football/italie-serie-b-e30")
    self.football_generic_scraper("https://www.betclic.fr/football/italie-coupe-e50")
    self.football_generic_scraper("https://www.betclic.fr/football/allemagne-bundesliga-e5")
    self.football_generic_scraper("https://www.betclic.fr/football/allemagne-coupe-e55")
    self.football_generic_scraper("https://www.betclic.fr/football/portugal-primeira-liga-e32")

  end

  # BAsic Scrapper of the Betclic League Page
  def self.football_generic_scraper(base_url)
    footballurl = base_url
    platform = 'BetClic'
    # response = Typhoeus.get(football_url, followlocation: true)
    page = Nokogiri::HTML(open(footballurl))
    # Get all the coming days in the page
    coming_days = page.css('#competition-events .day-entry')
    # Go through all the days
    coming_days.each do |daycode|
      # Get the Day
      date = daycode.css('.section-title time')
      day = date.text.to_s.to_date

      # Get all the Game entries in the Day section
      day_games = daycode.css('.schedule')
      day_games.each do |game_trade|
        # Get the Game Name
        name = game_trade.css('.match-name').text
        # Get the teams name
        teams = name.split('-')
        team_first = teams.first.to_s
        team_second = teams.last.to_s
        # Get the time
        time = game_trade.css('.hour').text
        # Get the links
        link = game_trade.css('a').first
        if !link.blank?
          url = footballurl.to_s + link['href']
        else
          url = nil
        end
        # Get the odds
        odds = game_trade.css('.match-odds .match-odd')
        first_ratio = odds[0].text.to_s.gsub(',', '.').to_f
        both_ratio = odds[1].text.to_s.gsub(',', '.').to_f
        second_ratio = odds[2].text.to_s.gsub(',', '.').to_f

        # Creation or update of the Trade
        FootballTrade.create_or_update(bet_platform_name: platform, bet_platform_url: url, team_first_name: team_first, team_second_name: team_second, event_date: day, first_winning_ratio: first_ratio, both_winning_ratio: both_ratio,
                             second_winning_ratio: second_ratio, last_update: Time.zone.now)

      end
    end
  end


end
