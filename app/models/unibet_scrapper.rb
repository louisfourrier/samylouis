# Not operational
class UnibetScrapper
  require 'rubygems'
  require 'nokogiri'
  require 'open-uri'
  require 'uri'


  def self.football_scraper
    footballurl = "https://www.unibet.fr/sport/football/top-championnats-europeens"
    platform = "Unibet"
    #response = Typhoeus.get(football_url, followlocation: true)
    #page = Nokogiri::HTML(open(footballurl))

    # Use the Javascript Scraper
    scrapper = JsScrapper.new
    page = scrapper.get_page_data(footballurl)
    # Get all the coming days in the page
    coming_days = page.css('.eventpath-wrapper .box')
    # Go through all the days
    coming_days.each do |daycode|
      # Get the Day
      date = daycode.css('h2')
      day = date.text.to_s.to_date

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
        time = game_trade.css('span.time').first.text
        # Get the links
        link = game_trade.css('a.cell-meta').first
        if !link.blank?
          url = link['href']
        else
          url = nil
        end
        # Get the odds
        odds = game_trade.css('.cell-market.markets .price')
        first_ratio = odds[0].text.to_s.gsub(',', '.').to_f
        both_ratio = odds[1].text.to_s.gsub(',', '.').to_f
        second_ratio = odds[2].text.to_s.gsub(',', '.').to_f

        FootballTrade.create(bet_platform_name: platform, bet_platform_url: url, team_first_name: team_first, team_second_name: team_second, event_date: day, event_time: time,  first_winning_ratio: first_ratio, both_winning_ratio: both_ratio,
        second_winning_ratio:second_ratio, last_update: Time.zone.now)

      end
    end
    # coming_games.each do |game|
    #   puts game.css('.match-name').text
    # end

  end



end
