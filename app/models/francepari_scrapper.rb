# France Pari Scrapper
class FrancepariScrapper
  require 'rubygems'
  require 'nokogiri'
  require 'open-uri'
  require 'uri'

  def self.football_scraper
    footballurl = 'https://www.france-pari.fr/sportif/pari/sport/id/13/pariez-sur-Football'
    platform = 'FrancePari'
    # response = Typhoeus.get(football_url, followlocation: true)
    page = Nokogiri::HTML(open(footballurl))
    # Get all the coming days in the page
    coming_games = page.css('#typ1 .padding5')
    # Go Line by Line if find a date modify the date
    # By default the first date is today
    day = Date.today
    coming_games.each do |line|
      # Get the Day
      if !line.css('.date-mm').empty?
        date = line.css('.date-mm').text.to_date
        puts date
        day = date

      else
        time = line.css('.heure-mm').text
        event_name = line.css('.match-mm.middle').text

        teams = event_name.split('/')
        team_first = teams.first.to_s
        team_second = teams.last.to_s

        link = line.css('.match-mm.middle a').first['href'].to_s

        odds = line.css('.coteseul')

        first_ratio = odds[0].text.to_s.gsub(',', '.').to_f
        both_ratio = odds[1].text.to_s.gsub(',', '.').to_f
        second_ratio = odds[2].text.to_s.gsub(',', '.').to_f

        FootballTrade.create(bet_platform_name: platform, bet_platform_url: link, team_first_name: team_first, team_second_name: team_second, event_date: day, event_time: time, first_winning_ratio: first_ratio, both_winning_ratio: both_ratio,
                             second_winning_ratio: second_ratio, last_update: Time.zone.now)



      end

    end
  end
end
