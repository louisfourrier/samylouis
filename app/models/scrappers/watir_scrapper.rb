class WatirScrapper
  require "watir"
  require 'watir-webdriver'

  def self.initialize_browser
    @browser ||= Watir::Browser.new
  end


  def self.html_website(url, time = 10)
    browser = self.initialize_browser
    browser.goto url
    sleep(time)
    html = browser.html
    page = Nokogiri::HTML(html)
  end

end
