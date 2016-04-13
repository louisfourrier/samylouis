class PmuScrapper
  require 'rubygems'
  require 'nokogiri'
  require 'open-uri'
  require 'uri'

  def self.football_scrapper
    self.football_generic_scrapper("http://paris-sportifs.pmu.fr/pari/football/ligue-1")
    self.football_generic_scrapper("http://paris-sportifs.pmu.fr/pari/football/ligue-2")
    self.football_generic_scrapper("http://paris-sportifs.pmu.fr/pari/football/coupe-de-france")
    self.football_generic_scrapper("http://paris-sportifs.pmu.fr/pari/football/coupe-de-la-ligue")
    self.football_generic_scrapper("http://paris-sportifs.pmu.fr/pari/football/allemagne")
    self.football_generic_scrapper("http://paris-sportifs.pmu.fr/pari/football/angleterre")
    self.football_generic_scrapper("http://paris-sportifs.pmu.fr/pari/football/espagne")
    self.football_generic_scrapper("http://paris-sportifs.pmu.fr/pari/football/italie")
    self.football_generic_scrapper("http://paris-sportifs.pmu.fr/pari/football/portugal")
  end

  def self.tennis_scrapper
    self.tennis_generic_scrapper("http://paris-sportifs.pmu.fr/home/tags/homepage_tab2")
  end

  def self.basket_scrapper
    self.basket_generic_scrapper("http://paris-sportifs.pmu.fr/pari/basketball-euro")
    self.basket_generic_scrapper("http://paris-sportifs.pmu.fr/pari/basketball-us")
  end

  def self.basket_generic_scrapper(url)
    platform = 'Pmu'
    sport = "basket"
    scenario_name = "1:2 win-lose"
    # response = Typhoeus.get(football_url, followlocation: true)
    page = Nokogiri::HTML(open(url))
    # Get all the coming days in the page
    coming_days = page.css('.choisissezPari .middleBlockContent')
    # Go through all the days
    coming_days.each do |daycode|

      # Get the Day
      date = daycode.css('.table1 .pmurft-cpfDate')
      puts date.text.to_s
      day = correct_date(date)

      # Get all the Game entries in the Day section
      day_games = daycode.css('.table2')
      day_games.each do |game_trade|
        begin
        # Get the Game Name
        name = game_trade.css('.event-name-link a').text
        # Get the teams name
        teams = name.split('//')
        team_first = teams.first.to_s
        team_second = teams.last.to_s

        # Get the time
        time = game_trade.css('.event-start-time').first.text.to_s
        # Get the links
        link = game_trade.css('.event-name-link a').first
        if !link.blank?
          url = link['href']
        else
          url = nil
        end
        # Get the odds
        odds = game_trade.css('.line2 .centralSel .btnBigGrey span')
        first_ratio = odds[0].text.to_s.gsub(',', '.').to_f
        second_ratio = odds[1].text.to_s.gsub(',', '.').to_f

        # Create the Sport Trade
        st = SportTrade.create_or_update(platform_name: platform, platform_url: link, team_first: team_first, team_second: team_second, event_time: time, sport: sport, event_date: day, scenario_name: scenario_name,  last_update: Time.zone.now)
        st.add_update_odd("first_team", first_ratio, team_first)
        st.add_update_odd("second_team", second_ratio, team_second)
      rescue
        puts "Error in scraping"
      end
      end
    end
  end

  def self.tennis_generic_scrapper(url)
    platform = 'Pmu'
    sport = "tennis"
    scenario_name = "1:2 win-lose"
    # response = Typhoeus.get(football_url, followlocation: true)
    page = Nokogiri::HTML(open(url))
    # Get all the coming days in the page
    coming_days = page.css('.choisissezPari .middleBlockContent')
    # Go through all the days
    coming_days.each do |daycode|

      # Get the Day
      date = daycode.css('.table1 .pmurft-cpfDate')
      puts date.text.to_s
      day = correct_date(date)

      # Get all the Game entries in the Day section
      day_games = daycode.css('.table2')
      day_games.each do |game_trade|
        begin
        # Get the Game Name
        name = game_trade.css('.event-name-link a').text
        # Get the teams name
        teams = name.split('//')
        team_first = teams.first.to_s
        team_second = teams.last.to_s

        # Get the time
        time = game_trade.css('.event-start-time').first.text.to_s
        # Get the links
        link = game_trade.css('.event-name-link a').first
        if !link.blank?
          url = link['href']
        else
          url = nil
        end
        # Get the odds
        odds = game_trade.css('.line2 .centralSel .btnBigGrey span')
        first_ratio = odds[0].text.to_s.gsub(',', '.').to_f
        second_ratio = odds[1].text.to_s.gsub(',', '.').to_f

        # Create the Sport Trade
        st = SportTrade.create_or_update(platform_name: platform, platform_url: link, team_first: team_first, team_second: team_second, event_time: time, sport: sport, event_date: day, scenario_name: scenario_name,  last_update: Time.zone.now)
        st.add_update_odd("first_team", first_ratio, team_first)
        st.add_update_odd("second_team", second_ratio, team_second)
      rescue
        puts "Error in scraping"
      end
      end
    end
  end

  def self.football_generic_scrapper(url)
    footballurl = url
    platform = 'Pmu'
    sport = "football"
    scenario_name = "1:3 win-null-lose"
    # response = Typhoeus.get(football_url, followlocation: true)
    page = Nokogiri::HTML(open(footballurl))
    # Get all the coming days in the page
    coming_days = page.css('.choisissezPari .middleBlockContent')
    # Go through all the days
    coming_days.each do |daycode|
      # Get the Day
      date = daycode.css('.table1 .pmurft-cpfDate')
      puts date.text.to_s
      day = correct_date(date)

      # Get all the Game entries in the Day section
      day_games = daycode.css('.table2')
      day_games.each do |game_trade|
        # Get the Game Name
        name = game_trade.css('.event-name-link a').text
        # Get the teams name
        teams = name.split('//')
        team_first = teams.first.to_s
        team_second = teams.last.to_s

        # Get the time
        time = game_trade.css('.event-start-time').first.text.to_s
        # Get the links
        link = game_trade.css('.event-name-link a').first
        if !link.blank?
          url = link['href']
        else
          url = nil
        end
        # Get the odds
        odds = game_trade.css('.line2 .centralSel .btnBigGrey span')
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

  # Correct Date from Scrapping to be recognized
  def self.correct_date(date_node)
    date_string = date_node.text.to_s
    new_words = []
    words = date_string.split(' ')
    words.shift
    if !words.empty?
      if (!words[0].nil?) & (words[0].length == 1)
        words[0] = '0' + words[0].to_s
      end
    else
      return nil
    end
    words.join(' ').to_s.to_date
  end


end
