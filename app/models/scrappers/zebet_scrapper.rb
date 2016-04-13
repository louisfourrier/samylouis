# Net Bet Scrapper
class ZebetScrapper
  require 'rubygems'
  require 'nokogiri'
  require 'open-uri'
  require 'uri'

  def self.football_scrapper
    footballurl = 'https://www.zebet.fr/fr/sport/13-football/paris'
    platform = 'Zebet'
    sport = "football"
    scenario_name = "1:3 win-null-lose"
    # response = Typhoeus.get(football_url, followlocation: true)
    page = Nokogiri::HTML(open(footballurl))
    # Get all the coming days in the page
    coming_games = page.css('table.table-bets tr')
    # Go Line by Line if find a date modify the date
    # By default the first date is today

    coming_games.each do |line|
        # Get the Day
        if line.css('.bet-time').text.to_s.include? '/'
          date = line.css('.bet-time').text.to_s.split(' ').first
          date = Date.strptime(date.to_s, "%d/%m")
          puts date
          day = date
        else
          day = Date.today
        end

      team_first = line.css('.bet-actor1 .pmq-cote-acteur').text.to_s
      team_second = line.css('.bet-actor2 .pmq-cote-acteur').text.to_s
      link = "https://www.zebet.fr" + line.css('.bet-actor1 a').first['href'].to_s

      first_ratio = line.css('.bet-actor1 .pmq-cote').text.to_s.gsub(',', '.').to_f
      both_ratio = line.css('.bet-actorN .pmq-cote').text.to_s.gsub(',', '.').to_f
      second_ratio = line.css('.bet-actor2 .pmq-cote').text.to_s.gsub(',', '.').to_f

      time = nil

      # Creation or update of the Trade
      st = SportTrade.create_or_update(platform_name: platform, platform_url: link, team_first: team_first, team_second: team_second, event_time: time, sport: sport, event_date: day, scenario_name: scenario_name,  last_update: Time.zone.now)
      st.add_update_odd("first_team", first_ratio, team_first)
      st.add_update_odd("equality", both_ratio, "Match nul")
      st.add_update_odd("second_team", second_ratio, team_second)

    end
  end

  def self.tennis_scrapper
        url = 'https://www.zebet.fr/fr/sport/21-tennis/paris'
        platform = 'ZeBet'
        sport = "tennis"
        scenario_name = "1:2 win-lose"
        page = Nokogiri::HTML(open(url))
        # Get all the coming days in the page
        coming_games = page.css('table.table-bets.item-content tr')
        # Go Line by Line if find a date modify the date
        # By default the first date is today

        coming_games.each do |line|
          # Get the Day
          if line.css('.bet-time').text.to_s.include? '/'
            date = line.css('.bet-time').text.to_s.split(' ').first
            date = Date.strptime(date.to_s, "%d/%m")
            puts date
            day = date
          else
            day = Date.today
          end

          team_first = line.css('.bet-actor1 .pmq-cote-acteur').text.to_s
          team_second = line.css('.bet-actor2 .pmq-cote-acteur').text.to_s
          link = "https://www.zebet.fr" + line.css('.bet-actor1 a').first['href'].to_s

          first_ratio = line.css('.bet-actor1 .pmq-cote').text.to_s.gsub(',', '.').to_f
          second_ratio = line.css('.bet-actor2 .pmq-cote').text.to_s.gsub(',', '.').to_f

          time = nil

          # Create the Sport Trade
          st = SportTrade.create_or_update(platform_name: platform, platform_url: link, team_first: team_first, team_second: team_second, event_time: time, sport: sport, event_date: day, scenario_name: scenario_name,  last_update: Time.zone.now)
          st.add_update_odd("first_team", first_ratio, team_first)
          st.add_update_odd("second_team", second_ratio, team_second)
        end
  end

  def self.basket_scrapper
        url = 'https://www.zebet.fr/fr/sport/4-basketball/paris'
        platform = 'ZeBet'
        sport = "basket"
        scenario_name = "1:2 win-lose"
        page = Nokogiri::HTML(open(url))
        # Get all the coming days in the page
        coming_games = page.css('table.table-bets.item-content tr')
        # Go Line by Line if find a date modify the date
        # By default the first date is today

        coming_games.each do |line|
          # Get the Day
          if line.css('.bet-time').text.to_s.include? '/'
            date = line.css('.bet-time').text.to_s.split(' ').first
            date = Date.strptime(date.to_s, "%d/%m")
            puts date
            day = date
          else
            day = Date.today
          end

          team_first = line.css('.bet-actor1 .pmq-cote-acteur').text.to_s
          team_second = line.css('.bet-actor2 .pmq-cote-acteur').text.to_s
          link = "https://www.zebet.fr" + line.css('.bet-actor1 a').first['href'].to_s

          first_ratio = line.css('.bet-actor1 .pmq-cote').text.to_s.gsub(',', '.').to_f
          second_ratio = line.css('.bet-actor2 .pmq-cote').text.to_s.gsub(',', '.').to_f

          time = nil

          # Create the Sport Trade
          st = SportTrade.create_or_update(platform_name: platform, platform_url: link, team_first: team_first, team_second: team_second, event_time: time, sport: sport, event_date: day, scenario_name: scenario_name,  last_update: Time.zone.now)
          st.add_update_odd("first_team", first_ratio, team_first)
          st.add_update_odd("second_team", second_ratio, team_second)
        end
  end
end
