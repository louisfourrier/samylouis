# Not operational
class WinamaxScrapper
  require 'rubygems'
  require 'nokogiri'
  require 'open-uri'
  require 'uri'

  def self.football_scrapper
    self.football_generic_scrapper("https://www.winamax.fr/paris-sportifs#!/sports/1/7")
  end

  def self.football_generic_scrapper(url)
    footballurl = url
    platform = 'Winamax'
    sport = "football"
    scenario_name = "1:3 win-null-lose"
    # response = Typhoeus.get(football_url, followlocation: true)
    page = Nokogiri::HTML(open(footballurl))
    # Get all the coming days in the page
    coming_games = page.css('#typ1 .question-content')
    # Go Line by Line if find a date modify the date
    # By default the first date is today
    day = Date.today
    coming_games.each do |line|
      # Get the Day
      unless line.css('.game-day-title').empty?
        date = line.css('.game-day-title').text.to_date
        puts date
        day = date
      end

      game = line.css('.win-the-game-content')

      time = game.css('.td-time').text
      event_name = game.css('.td-name').text

      teams = event_name.split('/')

      team_first = teams.first.to_s
      team_second = teams.last.to_s
      link = game.css('.td-name a').first['href'].to_s

      odds = game.css('span.td-cote')

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
