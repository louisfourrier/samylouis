

class JsScrapper
  require 'rubygems'
  require 'capybara'
  require 'capybara/dsl'
  require 'capybara/poltergeist'

  Capybara.default_driver = :poltergeist
  Capybara.javascript_driver = :poltergeist
  Capybara.run_server = false

    include Capybara::DSL

    def get_page_data(url)
      visit(url)
      doc = Nokogiri::HTML(page.html)
      return doc
    end


end
