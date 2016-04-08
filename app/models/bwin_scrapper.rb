# BeWin Scraper
class BwinScrapper
    require 'rubygems'
  require 'nokogiri'
  require 'open-uri'
  require 'uri'

  def self.football_scraper
      self.football_generic_scraper
  end

  def self.football_generic_scraper
      footballurl = "https://sports.bwin.fr/fr/sports#eventId=&leagueIds=19328,20447,21690,20853,23934&orderMode=Date&page=0&sportId=4"
    platform = 'Bwin'
    # response = Typhoeus.get(football_url, followlocation: true)
    pages = [0, 1, 2]
    pages.each do |pagination|
        page = TyphoeusScrapper.post_request_bwin('4', '19328,23934,20447,21690,20853,20529,19327,21658,21673,19333,21660,21676,19331,21661,21674,19329,21657,21671,20486', pagination)
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

          FootballTrade.create(bet_platform_name: platform, bet_platform_url: link, team_first_name: team_first, team_second_name: team_second, event_date: day, first_winning_ratio: first_ratio, both_winning_ratio: both_ratio,
                               second_winning_ratio: second_ratio, last_update: Time.zone.now)

        end
      end
    end
  end
end
