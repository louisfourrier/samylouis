
# Betclic scrapper
class BetfirstScrapper
  require 'rubygems'
  require 'nokogiri'
  require 'open-uri'
  require 'uri'

  # Get all the links corresponding to each league
  def self.football_scrapper
    self.football_generic_scrapper("https://www.betclic.fr/football/ligue-1-e4")
    self.football_generic_scrapper("https://www.betclic.fr/football/ligue-2-e19")
    self.football_generic_scrapper("https://www.betclic.fr/football/ligue-des-champions-e8")
    self.football_generic_scrapper("https://www.betclic.fr/football/europa-league-e3453")
    self.football_generic_scrapper("https://www.betclic.fr/football/angl-premier-league-e3")
    self.football_generic_scrapper("https://www.betclic.fr/football/angl-championship-e28")
    self.football_generic_scrapper("https://www.betclic.fr/football/espagne-liga-primera-e7")
    self.football_generic_scrapper("https://www.betclic.fr/football/espagne-liga-segunda-e31")
    self.football_generic_scrapper("https://www.betclic.fr/football/espagne-coupe-du-roi-e47")
    self.football_generic_scrapper("https://www.betclic.fr/football/italie-serie-a-e6")
    self.football_generic_scrapper("https://www.betclic.fr/football/italie-serie-b-e30")
    self.football_generic_scrapper("https://www.betclic.fr/football/italie-coupe-e50")
    self.football_generic_scrapper("https://www.betclic.fr/football/allemagne-bundesliga-e5")
    self.football_generic_scrapper("https://www.betclic.fr/football/allemagne-coupe-e55")
    self.football_generic_scrapper("https://www.betclic.fr/football/portugal-primeira-liga-e32")

  end

  def self.tennis_scrapper
    self.tennis_generic_scrapper("https://www.betclic.fr/calendrier-0?From=&SortBy=Date&Live=false&MultipleBoost=false&Competitions.Selected=2-0&StartIndex=0&Search=")
  end

  # BAsic Scrapper of the Betclic League Page
  def self.football_generic_scrapper(base_url)
    footballurl = base_url
    platform = 'BetClic'
    sport = "football"
    scenario_name = "1:3 win-null-lose"
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
          url = footballurl.to_s + link['href'].to_s
        else
          url = nil
        end
        # Get the odds
        odds = game_trade.css('.match-odds .match-odd')
        first_ratio = odds[0].text.to_s.gsub(',', '.').to_f
        both_ratio = odds[1].text.to_s.gsub(',', '.').to_f
        second_ratio = odds[2].text.to_s.gsub(',', '.').to_f

        # Creation or update of the Trade
        st = SportTrade.create_or_update(platform_name: platform, platform_url: link, team_first: team_first, team_second: team_second, event_time: time, sport: sport, event_date: day, scenario_name: scenario_name,  last_update: Time.zone.now)
        st.add_update_odd("first_team", first_ratio, team_first)
        st.add_update_odd("equality", both_ratio, "Match nul")
        st.add_update_odd("second_team", second_ratio, team_second)

      end
    end
  end

  # BAsic Scrapper of the Betclic League Page
  def self.tennis_generic_scrapper(base_url)
    platform = 'BetClic'
    sport = "tennis"
    scenario_name = "1:2 win-lose"
    # response = Typhoeus.get(football_url, followlocation: true)
    page = Nokogiri::HTML(open(base_url))
    # Get all the coming days in the page
    coming_days = page.css('#cal-wrapper-prelive .cal-day-entry')
    # Go through all the days
    coming_days.each do |daycode|
      # Get the Day
      date = daycode.css('.section-title > span').first.text
      date_array = date.to_s.split(' ')
      date_array.shift
      date = date_array.join(' ')
      day = date.to_s.to_date

      # Get all the Game entries in the Day section
      day_games = daycode.css('.match-entry')
      day_games.each do |game_trade|
        begin
        # Get the Game Name
        name = game_trade.css('.match-name').text
        # Get the teams name
        teams = name.split('-')
        team_first = teams.first.to_s
        team_second = teams.last.to_s
        # Get the time
        time = nil
        # Get the links
        link = base_url
        # Get the odds
        odds = game_trade.css('.match-odds .odd-button')
        first_ratio = odds[0].text.to_s.gsub(',', '.').to_f
        second_ratio = odds[1].text.to_s.gsub(',', '.').to_f

        # Creation or update of the Trade
        # Create the Sport Trade
        st = SportTrade.create_or_update(platform_name: platform, platform_url: link, team_first: team_first, team_second: team_second, event_time: time, sport: sport, event_date: day, scenario_name: scenario_name,  last_update: Time.zone.now)
        st.add_update_odd("first_team", first_ratio, team_first)
        st.add_update_odd("second_team", second_ratio, team_second)
      rescue
        puts "Errors in Scraping BetClic Tennis entry"
      end

      end
    end
  end




end
