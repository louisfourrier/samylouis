# Parions Web Scrapper
class ParionswebScrapper
  require 'rubygems'
  require 'nokogiri'
  require 'open-uri'
  require 'uri'

  def self.football_scrapper
    generic_football_scrapper('https://parionsweb.fdj.fr/paris-football/france')
    generic_football_scrapper('https://parionsweb.fdj.fr/paris-football/angleterre')
    generic_football_scrapper('https://parionsweb.fdj.fr/paris-football/espagne')
    generic_football_scrapper('https://parionsweb.fdj.fr/paris-football/italie')
    generic_football_scrapper('https://parionsweb.fdj.fr/paris-football/allemagne')
    generic_football_scrapper('https://parionsweb.fdj.fr/paris-football/coupes-deurope')
  end

  def self.tennis_scrapper
    generic_tennis_scrapper('https://parionsweb.fdj.fr/paris-tennis')
  end

  def self.basket_scrapper
    generic_basket_scrapper('https://parionsweb.fdj.fr/paris-basketball')
  end

  def self.generic_football_scrapper(url)
    footballurl = url
    platform = 'ParionsWeb'
    sport = "football"
    scenario_name = "1:3 win-null-lose"
    # response = Typhoeus.get(football_url, followlocation: true)
    page = Nokogiri::HTML(open(footballurl))
    # Get all the coming days in the page
    coming_days = page.css('#tab_gameevent .event-block')
    # Go through all the days
    coming_days.each do |daycode|
      # Get the Day
      date = daycode.css('.events-date').text.to_s.strip
      date_words = date.to_s.split(' ')
      date_words.shift
      date = date_words.join(' ')
      puts date
      day = date.to_date

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
        time =  game_trade.css('.time').text
        # Get the links
        link = game_trade.css('.outcomes.inline-market a').first
        if !link.blank?
          url = "https://parionsweb.fdj.fr" + link['href']
        else
          url = nil
        end
        # Get the odds
        odds = game_trade.css('.odds .odd .formatted_price')
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

  def self.generic_tennis_scrapper(url)
    platform = 'ParionsWeb'
    sport = "tennis"
    scenario_name = "1:2 win-lose"
    # response = Typhoeus.get(football_url, followlocation: true)
    page = Nokogiri::HTML(open(url))
    # Get all the coming days in the page
    coming_days = page.css('#tab_gameevent .event-block')
    # Go through all the days
    coming_days.each do |daycode|
      # Get the Day
      date = daycode.css('.events-date').text.to_s.strip
      date_clean = date.split(' ')
      date_clean.shift
      day = date_clean.join(' ').to_date
      puts day

      # Get all the Game entries in the Day section
      day_games = daycode.css('.market.market-inline-separate')
      day_games.each do |game_trade|
        # Get the Game Name
        name = game_trade.css('.outcomes.inline-market').text
        # Get the teams name
        teams = name.split('-')
        team_first = teams.first.to_s.split('.').last
        team_second = teams.last.to_s.split('.').last
        # Get Time
        event_time =  game_trade.css('.time').text
        time = event_time
        # Get the links
        link = game_trade.css('.outcomes.inline-market a').first
        if !link.blank?
          url = "https://parionsweb.fdj.fr" + link['href']
        else
          url = nil
        end
        # Get the odds
        odds = game_trade.css('.odds .odd .formatted_price')
        first_ratio = odds[0].text.to_s.gsub(',', '.').to_f
        second_ratio = odds[1].text.to_s.gsub(',', '.').to_f

        # Create the Sport Trade
        st = SportTrade.create_or_update(platform_name: platform, platform_url: link, team_first: team_first, team_second: team_second, event_time: time, sport: sport, event_date: day, scenario_name: scenario_name,  last_update: Time.zone.now)
        st.add_update_odd("first_team", first_ratio, team_first)
        st.add_update_odd("second_team", second_ratio, team_second)


      end
    end
  end

  def self.generic_basket_scrapper(url)
    footballurl = url
    platform = 'ParionsWeb'
    sport = "basket"
    scenario_name = "1:2 win-lose"
    # response = Typhoeus.get(football_url, followlocation: true)
    page = Nokogiri::HTML(open(footballurl))
    # Get all the coming days in the page
    coming_days = page.css('#tab_gameevent .event-block')
    # Go through all the days
    coming_days.each do |daycode|
      # Get the Day
      date = daycode.css('.events-date').text.to_s.strip
      date_words = date.to_s.split(' ')
      date_words.shift
      date = date_words.join(' ')
      puts date
      day = date.to_date

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
        time =  game_trade.css('.time').text
        # Get the links
        link = game_trade.css('.outcomes.inline-market a').first
        if !link.blank?
          url = "https://parionsweb.fdj.fr" + link['href']
        else
          url = nil
        end
        # Get the odds
        odds = game_trade.css('.odds .odd .formatted_price')
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


end
