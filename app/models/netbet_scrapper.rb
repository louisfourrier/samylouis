# Net Bet Scrapper
class NetbetScrapper
  require 'rubygems'
  require 'nokogiri'
  require 'open-uri'
  require 'uri'

  def self.football_scraper

    footballurl = 'https://netbetsport.fr/pari/sport/id/13/pariez-sur-Football'
    platform = 'NetBet'
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

      FootballTrade.create(bet_platform_name: platform, bet_platform_url: link, team_first_name: team_first, team_second_name: team_second, event_date: day, event_time: time, first_winning_ratio: first_ratio, both_winning_ratio: both_ratio,
                           second_winning_ratio: second_ratio, last_update: Time.zone.now)

    end
  end
end
