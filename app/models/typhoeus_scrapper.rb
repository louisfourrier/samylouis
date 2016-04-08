# Special Scrapper for Post Request
class TyphoeusScrapper

  # Bwin post request
  def self.post_request_bwin(sport_id, leagueIds, page)
    request = Typhoeus::Request.new(
      'https://sports.bwin.fr/fr/sports/indexmultileague',
      method: :post,
      body: 'this is a request body',
      params: { sportId: sport_id, leagueIds: leagueIds.to_s, orderMode: 'Date', page: page.to_s },
      headers: { Accept: 'text/html' }
    )
    request.run
    response = request.response
    #response.body
    page = Nokogiri::HTML(response.body)
end

end
