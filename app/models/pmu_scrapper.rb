class PmuScrapper
  require 'rubygems'
  require 'nokogiri'
  require 'open-uri'
  require 'uri'

  def self.football_scraper
    self.football_generic_scraper("http://paris-sportifs.pmu.fr/pari/football/ligue-1")
    self.football_generic_scraper("http://paris-sportifs.pmu.fr/pari/football/ligue-2")
    self.football_generic_scraper("http://paris-sportifs.pmu.fr/pari/football/coupe-de-france")
    self.football_generic_scraper("http://paris-sportifs.pmu.fr/pari/football/coupe-de-la-ligue")
    self.football_generic_scraper("http://paris-sportifs.pmu.fr/pari/football/allemagne")
    self.football_generic_scraper("http://paris-sportifs.pmu.fr/pari/football/angleterre")
    self.football_generic_scraper("http://paris-sportifs.pmu.fr/pari/football/espagne")
    self.football_generic_scraper("http://paris-sportifs.pmu.fr/pari/football/italie")
    self.football_generic_scraper("http://paris-sportifs.pmu.fr/pari/football/portugal")
  end

  def self.football_generic_scraper(url)
    footballurl = url
    platform = 'Pmu'
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

        FootballTrade.create(bet_platform_name: platform, bet_platform_url: url, team_first_name: team_first, team_second_name: team_second, event_date: day, event_time: time, first_winning_ratio: first_ratio, both_winning_ratio: both_ratio,
                             second_winning_ratio: second_ratio, last_update: Time.zone.now)

      end
    end


  end

  # Correct Date from Scrapping to be recognized
  def self.correct_date(date_node)
    date_string = date_node.text.to_s
    new_words = []
    words = date_string.split(' ')
    if !words.empty?
      if (!words[1].nil?) & (words[1].length == 1)
        words[1] = '0' + words[1].to_s
      end
    else
      return nil
    end
    words.join(' ').to_s.to_date
  end

  
end
