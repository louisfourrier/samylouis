# Not operational
class UnibetScrapper
  require 'rubygems'
  require 'nokogiri'
  require 'open-uri'
  require 'uri'


  def self.football_scrapper
    football_url = "https://www.unibet.fr/sport/football/top-championnats-europeens"
    platform = "Unibet"
    sport = "football"
    scenario_name = "1:3 win-null-lose"

    page = WatirScrapper.html_website(football_url, 10)
    # Get all the coming days in the page
    coming_days = page.css('.eventpath-wrapper .box')
    # Go through all the days
    coming_days.each do |daycode|
      # Get the Day
      date = daycode.css('h2').text.to_s
      date_words = date.split(' ')
      date_words.shift
      date = date_words.join(' ').to_s
      day = date.to_date

      # Get all the Game entries in the Day section
      day_games = daycode.css('.inline-market.cell')
      day_games.each do |game_trade|
        # Get the Game Name
        name = game_trade.css('span.description').text
        # Get the teams name
        teams = name.split('-')
        team_first = teams.first.to_s
        team_second = teams.last.to_s
        # Get the time
        time = game_trade.css('span.datetime').first.text
        # Get the links
        link = game_trade.css('a.cell-meta').first
        if !link.blank?
          url = "https://www.unibet.fr" + link['href'].to_s
        else
          url = nil
        end
        # Get the odds
        odds = game_trade.css('.cell-market.markets .price')
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



  def self.tennis_scrapper
    url = "https://www.unibet.fr/sport/tennis"
    platform = "Unibet"
    sport = "tennis"
    scenario_name = "1:2 win-lose"

    page = WatirScrapper.html_website(url, 8)
    # Get all the coming days in the page
    coming_days = page.css('.eventpath-wrapper .box')
    # Go through all the days
    coming_days.each do |daycode|
      # Get the Day
      date = daycode.css('h2').text.to_s
      date_words = date.split(' ')
      date_words.shift
      date = date_words.join(' ').to_s
      day = date.to_date

      # Get all the Game entries in the Day section
      day_games = daycode.css('.inline-market.cell')
      day_games.each do |game_trade|
        # Get the Game Name
        name = game_trade.css('span.description').text
        # Get the teams name
        teams = name.split('-')
        team_first = teams.first.to_s.split(' ').first
        team_second = teams.last.to_s.split(' ').first
        # Get the time
        time = game_trade.css('span.datetime').first.text
        # Get the links
        link = game_trade.css('a.cell-meta').first
        if !link.blank?
          url = "https://www.unibet.fr" + link['href'].to_s
        else
          url = nil
        end
        # Get the odds
        odds = game_trade.css('.cell-market.markets .price')
        first_ratio = odds[0].text.to_s.gsub(',', '.').to_f
        second_ratio = odds[1].text.to_s.gsub(',', '.').to_f

        # Creation or update of the Trade
        st = SportTrade.create_or_update(platform_name: platform, platform_url: link, team_first: team_first, team_second: team_second, event_time: time, sport: sport, event_date: day, scenario_name: scenario_name,  last_update: Time.zone.now)
        st.add_update_odd("first_team", first_ratio, team_first)
        st.add_update_odd("second_team", second_ratio, team_second)

      end
    end
    # coming_games.each do |game|
    #   puts game.css('.match-name').text
    # end

  end


  def self.basket_scrapper
    url = "https://www.unibet.fr/sport/basketball"
    platform = "Unibet"
    sport = "basket"
    scenario_name = "1:2 win-lose"

    page = WatirScrapper.html_website(url, 8)
    # Get all the coming days in the page
    coming_days = page.css('.eventpath-wrapper .box')

    # Go through all the days
    coming_days.each do |daycode|
      # Get the Day
      date = daycode.css('h2').text.to_s
      date_words = date.split(' ')
      date_words.shift
      date = date_words.join(' ').to_s
      day = date.to_date

      # Get all the Game entries in the Day section
      day_games = daycode.css('.inline-market.cell')
      day_games.each do |game_trade|
        # Get the Game Name
        name = game_trade.css('span.description').text
        # Get the teams name
        teams = name.split('-')
        team_first = teams.first.to_s
        team_second = teams.last.to_s
        # Get the time
        time = game_trade.css('span.datetime').first.text
        # Get the links
        link = game_trade.css('a.cell-meta').first
        if !link.blank?
          url = "https://www.unibet.fr" + link['href'].to_s
        else
          url = nil
        end
        # Get the odds
        odds = game_trade.css('.cell-market.markets .price')
        if odds.count == 2
        first_ratio = odds[0].text.to_s.gsub(',', '.').to_f
        second_ratio = odds[1].text.to_s.gsub(',', '.').to_f

        # Creation or update of the Trade
        st = SportTrade.create_or_update(platform_name: platform, platform_url: link, team_first: team_first, team_second: team_second, event_time: time, sport: sport, event_date: day, scenario_name: scenario_name,  last_update: Time.zone.now)
        st.add_update_odd("first_team", first_ratio, team_first)
        st.add_update_odd("second_team", second_ratio, team_second)
        else

        end



      end
    end
    # coming_games.each do |game|
    #   puts game.css('.match-name').text
    # end

  end



end
