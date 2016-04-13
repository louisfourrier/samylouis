# BeWin Scraper
class BwinScrapper
    require 'rubygems'
  require 'nokogiri'
  require 'open-uri'
  require 'uri'

  def self.football_scrapper
    self.football_generic_scrapper
  end

  def self.tennis_scrapper
    self.tennis_generic_scrapper
  end

  def self.basket_scrapper
    self.basket_generic_scrapper
  end

  def self.basket_generic_scrapper
    platform = 'Bwin'
    sport = "basket"
    scenario_name = "1:2 win-lose"
    page = TyphoeusScrapper.basket_post_request_bwin(7)
    # Get all the coming days in the page
    games = page.css('#bet-offer .ui-widget-content-body')
      # Get all the Game entries in the Day section
      day_games = games.css('li.listing')
      day_games.each do |game_trade|

        # Get the Day
        date = game_trade.css('h6 span')[1]
        if date.nil?
          # Nothing continue next line
        else
          day = Date.strptime(date.text.to_s, "%d/%m")
          # Get the Names
          team_first = game_trade.css('.options .option-name').first.text
          team_second = game_trade.css('.options .option-name')[1].text
          # Get the time
          time = game_trade.css('h6 span')[0].text.to_s
          # Get the links
          link = nil
          # Get the odds
          odds = game_trade.css('.options .odds')
          first_ratio = odds[0].text.to_s.gsub(',', '.').to_f
          second_ratio = odds[1].text.to_s.gsub(',', '.').to_f

          st = SportTrade.create_or_update(platform_name: platform, platform_url: link, team_first: team_first, team_second: team_second, event_time: time, sport: sport, event_date: day, scenario_name: scenario_name,  last_update: Time.zone.now)
          st.add_update_odd("first_team", first_ratio, team_first)
          st.add_update_odd("second_team", second_ratio, team_second)
        end

      end
  end

  def self.tennis_generic_scrapper
    platform = 'Bwin'
    sport = "tennis"
    scenario_name = "1:2 win-lose"
    page = TyphoeusScrapper.tennis_post_request_bwin(5)
    # Get all the coming days in the page
    games = page.css('#bet-offer .ui-widget-content-body')
      # Get all the Game entries in the Day section
      day_games = games.css('li.listing')
      day_games.each do |game_trade|

        # Get the Day
        date = game_trade.css('h6 span')[1]
        if date.nil?
          # Nothing continue next line
        else
          day = Date.strptime(date.text.to_s, "%d/%m")
          # Get the Names
          team_first = game_trade.css('.options .option-name').first.text
          team_second = game_trade.css('.options .option-name')[1].text
          # Get the time
          time = game_trade.css('h6 span')[0].text.to_s
          # Get the links
          link = nil
          # Get the odds
          odds = game_trade.css('.options .odds')
          first_ratio = odds[0].text.to_s.gsub(',', '.').to_f
          second_ratio = odds[1].text.to_s.gsub(',', '.').to_f

          st = SportTrade.create_or_update(platform_name: platform, platform_url: link, team_first: team_first, team_second: team_second, event_time: time, sport: sport, event_date: day, scenario_name: scenario_name,  last_update: Time.zone.now)
          st.add_update_odd("first_team", first_ratio, team_first)
          st.add_update_odd("second_team", second_ratio, team_second)
        end

      end
  end

  def self.football_generic_scrapper
    footballurl = "https://sports.bwin.fr/fr/sports#eventId=&leagueIds=19328,20447,21690,20853,23934&orderMode=Date&page=0&sportId=4"
    platform = 'Bwin'
    sport = "football"
    scenario_name = "1:3 win-null-lose"
    # response = Typhoeus.get(football_url, followlocation: true)
    pages = [0, 1, 2]
    pages.each do |pagination|
      # Make A POST RESQUEST VIA Typhoeus
      page = TyphoeusScrapper.football_post_request_bwin('4', '19328,23934,20447,21690,20853,20529,19327,21658,21673,19333,21660,21676,19331,21661,21674,19329,21657,21671,20486', pagination)
      # Get all the coming days in the page
      coming_days = page.css('#markets .ui-widget-content-body')
      # Go through all the days
      coming_days.each do |daycode|
          # Get the Day
        date = daycode.css('.event-group-level3').text.to_s.strip
        date = date.to_s.split('-').last.to_s.strip
        day = date.to_s.to_date
        puts day

        # Get all the Game entries in the Day section
        day_games = daycode.css('li.listing')
        day_games.each do |game_trade|

            team_first = game_trade.css('.options .option-name').first.text
          team_second = game_trade.css('.options .option-name')[2].text
          # Get the time
          time = game_trade.css('.event-header-level0').text
          # Get the links
          link = nil
          # Get the odds
          odds = game_trade.css('.options .odds')
          first_ratio = odds[0].text.to_s.gsub(',', '.').to_f
          both_ratio = odds[1].text.to_s.gsub(',', '.').to_f
          second_ratio = odds[2].text.to_s.gsub(',', '.').to_f

          st = SportTrade.create_or_update(platform_name: platform, platform_url: link, team_first: team_first, team_second: team_second, event_time: time, sport: sport, event_date: day, scenario_name: scenario_name,  last_update: Time.zone.now)
          st.add_update_odd("first_team", first_ratio, team_first)
          st.add_update_odd("equality", both_ratio, "Match nul")
          st.add_update_odd("second_team", second_ratio, team_second)

        end
      end
    end
  end
end
