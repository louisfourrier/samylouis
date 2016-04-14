
# Betclic scrapper
class BetfirstScrapper
  require 'rubygems'
  require 'nokogiri'
  require 'open-uri'
  require 'uri'

  # Get all the links corresponding to each league
  def self.football_scrapper
    self.football_generic_scrapper("http://betfirst.dhnet.be/football/1_bundesliga")
  end

  def self.football_generic_scrapper( url)
    platform = "Betfirst"
    sport = "football"
    scenario_name = "1:3 win-null-lose"
    page = WatirScrapper.html_website(url, 9)
    # Get all the coming days in the page
    lines= page.css('.types_bg .time, .types_bg .bets')
    day = Date.today
    # Go through all the days
    lines.each do |line|

      if line['class'] == "time"
        puts "Time Class"
        date = line.text.to_s.split('|').first
        puts date
        day = Date.strptime(date.to_s, "%d/%m")
      else
        # Get the Game Name
        names = line.css('.team_betting span')
        # Get the teams name
        team_first = names.first.text.to_s
        team_second = names[1].text.to_s

        # Get the links
        link = nil
        # Get the odds
        odds = line.css('dd ul li span')
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
    # coming_games.each do |game|
    #   puts game.css('.match-name').text
    # end

  end





end
