# Net Bet Scrapper
class LadbrokeScrapper
  require 'rubygems'
  require 'nokogiri'
  require 'open-uri'
  require 'uri'

  def self.football_scrapper
    self.football_generic_scrapper("http://sports.ladbrokes.be/fr/PremierLeague")
    self.football_generic_scrapper("http://sports.ladbrokes.be/fr/t/23028/Championship")
    self.football_generic_scrapper("http://sports.ladbrokes.be/fr/t/23077/League-One")
    self.football_generic_scrapper("http://sports.ladbrokes.be/fr/t/22835/Primera-Liga")
    self.football_generic_scrapper("http://sports.ladbrokes.be/fr/t/22798/Segunda-Division")
    self.football_generic_scrapper("http://sports.ladbrokes.be/fr/t/22312/Serie-A")
    self.football_generic_scrapper("http://sports.ladbrokes.be/fr/t/22347/Serie-B")
    self.football_generic_scrapper("http://sports.ladbrokes.be/fr/t/21152/Ligue-1")
    self.football_generic_scrapper("http://sports.ladbrokes.be/fr/t/21149/Ligue-2")
    self.football_generic_scrapper("http://sports.ladbrokes.be/fr/t/21173/Championnat-National")
    self.football_generic_scrapper("http://sports.ladbrokes.be/fr/t/22745/Bundesliga")
    self.football_generic_scrapper("http://sports.ladbrokes.be/fr/t/22753/Bundesliga-2")
    self.football_generic_scrapper("http://sports.ladbrokes.be/fr/t/22788/Coupe-d%27Allemagne")
    self.football_generic_scrapper("http://sports.ladbrokes.be/fr/t/21905/Portuguese-Liga-Sagres")
  end

  def self.football_generic_scrapper(url)
    platform = 'Ladbroke'
    sport = "football"
    scenario_name = "1:3 win-null-lose"
    # response = Typhoeus.get(football_url, followlocation: true)
    page = Nokogiri::HTML(open(url))
    # Get all the coming days in the page
    coming_games = page.css('.coupon.coupon-horizontal.coupon-scoreboard tr.mkt_content')
    # Go Line by Line if find a date modify the date
    # By default the first date is today

    coming_games.each do |line|
      begin

      date = line.css('.ev span.date').first
      if date.nil?
        day = Date.today
      else
        day = date.text.to_s.to_date
      end

      teams = line.css('button .seln-name')

      team_first = teams[0].text.to_s
      team_second = teams[1].text.to_s
      link = nil
      time = nil

      odds = line.css('button .price.dec')

      first_ratio = odds[0].text.to_s.gsub(',', '.').to_f
      both_ratio = odds[1].text.to_s.gsub(',', '.').to_f
      second_ratio = odds[2].text.to_s.gsub(',', '.').to_f

      # Creation or update of the Trade
      st = SportTrade.create_or_update(platform_name: platform, platform_url: link, team_first: team_first, team_second: team_second, event_time: time, sport: sport, event_date: day, scenario_name: scenario_name,  last_update: Time.zone.now)
      st.add_update_odd("first_team", first_ratio, team_first)
      st.add_update_odd("equality", both_ratio, "Match nul")
      st.add_update_odd("second_team", second_ratio, team_second)
    rescue
      puts "Error in Ladbrokes scrapping football"
    end

    end
  end

  def self.tennis_scrapper
      url = 'http://sports.ladbrokes.be/fr/Tennis'
      platform = 'Ladbroke'
      sport = "tennis"
      scenario_name = "1:2 win-lose"
      # response = Typhoeus.get(football_url, followlocation: true)
      page = Nokogiri::HTML(open(url))
      # Get all the coming days in the page
      coming_games = page.css('.coupon.coupon-horizontal.coupon-scoreboard tr.mkt_content')
      # Go Line by Line if find a date modify the date
      # By default the first date is today

      coming_games.each do |line|
        #begin

        date = line.css('.ev span.date').first
        if date.nil?
          day = Date.today
        else
          day = date.text.to_s.to_date
        end

        teams = line.css('button .seln-name')

        team_first = teams[0].text.to_s
        team_second = teams[1].text.to_s
        link = nil
        time = nil

        odds = line.css('button .price.dec')

        first_ratio = odds[0].text.to_s.gsub(',', '.').to_f
        second_ratio = odds[1].text.to_s.gsub(',', '.').to_f

        # Create the Sport Trade
        st = SportTrade.create_or_update(platform_name: platform, platform_url: link, team_first: team_first, team_second: team_second, event_time: time, sport: sport, event_date: day, scenario_name: scenario_name,  last_update: Time.zone.now)
        st.add_update_odd("first_team", first_ratio, team_first)
        st.add_update_odd("second_team", second_ratio, team_second)
      # rescue
      #   puts "Error in Ladbrokes scrapping football"
      # end

      end
  end

  def self.basket_scrapper
        url = 'http://sports.ladbrokes.be/fr/Basketball'
        platform = 'Ladbroke'
        sport = "basket"
        scenario_name = "1:2 win-lose"
        # response = Typhoeus.get(football_url, followlocation: true)
        page = Nokogiri::HTML(open(url))
        # Get all the coming days in the page
        coming_games = page.css('.coupon.coupon-horizontal.coupon-scoreboard tr.mkt_content')
        # Go Line by Line if find a date modify the date
        # By default the first date is today
        #day = Date.today
        coming_games.each do |line|
          #begin

          date = line.css('.ev span.date').first
          if date.nil?
            day = Date.today
          else
            day = date.text.to_s.to_date
          end

          teams = line.css('button .seln-name')

          team_first = teams[0].text.to_s
          team_second = teams[1].text.to_s
          link = nil
          time = nil

          odds = line.css('button .price.dec')

          first_ratio = odds[0].text.to_s.gsub(',', '.').to_f
          second_ratio = odds[1].text.to_s.gsub(',', '.').to_f

          # Create the Sport Trade
          st = SportTrade.create_or_update(platform_name: platform, platform_url: link, team_first: team_first, team_second: team_second, event_time: time, sport: sport, event_date: day, scenario_name: scenario_name,  last_update: Time.zone.now)
          st.add_update_odd("first_team", first_ratio, team_first)
          st.add_update_odd("second_team", second_ratio, team_second)
        # rescue
        #   puts "Error in Ladbrokes scrapping football"
        # end

        end
    end
end
