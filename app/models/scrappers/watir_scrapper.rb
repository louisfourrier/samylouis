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


  def self.glass_door_scrapper
    url = "https://www.glassdoor.fr/Avis/%C3%A9tats-unis-avis-SRCH_IL.0,10_IN1.htm"
    next_url = url
    browser = Watir::Browser.new(:firefox)
    array = []


    while next_url

      browser.goto(next_url)
      browser.wait(5)

      html = browser.html
      page = Nokogiri::HTML(html)

      names = page.css('.snug .h1')
      names.each do |name|
        puts name.text.to_s
        array << name.text.to_s
      end

      next_url = page.css('#FooterPageNav .pagingControls li.next a').first
      if next_url
        part_url = next_url['href']
        next_url = "https://www.glassdoor.fr" + part_url
        puts "next url is #{next_url}"

      else
        puts "No next_url"
      end

      random_sleep = rand() * 5
      sleep_time = random_sleep + 6
      sleep(sleep_time)
    end

  end

end
