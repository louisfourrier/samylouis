# Not operational
class WinamaxScrapper
  require 'rubygems'
  require 'nokogiri'
  require 'open-uri'
  require 'uri'

  def self.football_scrapper
    self.football_generic_scrapper("https://www.winamax.fr/paris-sportifs#!/sports/1/7")
    self.football_generic_scrapper("https://www.winamax.fr/paris-sportifs#!/sports/1/1")
    self.football_generic_scrapper("https://www.winamax.fr/paris-sportifs#!/sports/1/32")
    self.football_generic_scrapper("https://www.winamax.fr/paris-sportifs#!/sports/1/31")
    self.football_generic_scrapper("https://www.winamax.fr/paris-sportifs#!/sports/1/30")
    self.football_generic_scrapper("https://www.winamax.fr/paris-sportifs#!/sports/1/44")
    self.football_generic_scrapper("https://www.winamax.fr/paris-sportifs#!/sports/1/800000007")
  end

  def self.football_generic_scrapper(url)
    platform = 'Winamax'
    sport = "football"
    scenario_name = "1:3 win-null-lose"
    # response = Typhoeus.get(football_url, followlocation: true)
    page = WatirScrapper.html_website(url, 10)
    # Get all the coming days in the page
    coming_games = page.css('.event-list .event.cat')
    # Go Line by Line if find a date modify the date
    # By default the first date is today
    day = Date.today
    time = nil
    coming_games.each do |line|
      begin
      # Get the Day
      unless line.css('.date-title').empty?
        date = line.css('.date-title').text.to_s
        date_words = date.split(' ')
        date_words.shift
        date = date_words.join(' ')
        puts date
        day = date.to_date
        time = line.css('.time').text.to_s
      end

      event_name = line.css('.event-name').text

      teams = event_name.split('-')
      team_first = teams.first.to_s
      team_second = teams.last.to_s

      link = line.css('.event-name a').first['href'].to_s

      odds = line.css('.odd-button .variable')

      first_ratio = odds[0].text.to_s.gsub(',', '.').to_f
      both_ratio = odds[1].text.to_s.gsub(',', '.').to_f
      second_ratio = odds[2].text.to_s.gsub(',', '.').to_f

      # Creation or update of the Trade
      st = SportTrade.create_or_update(platform_name: platform, platform_url: link, team_first: team_first, team_second: team_second, event_time: time, sport: sport, event_date: day, scenario_name: scenario_name,  last_update: Time.zone.now)
      st.add_update_odd("first_team", first_ratio, team_first)
      st.add_update_odd("equality", both_ratio, "Match nul")
      st.add_update_odd("second_team", second_ratio, team_second)
    rescue
      puts "Errors in Winamax football scrapper"
    end

    end


  end
end
