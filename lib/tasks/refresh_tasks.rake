task :clean_outdated => :environment do
  puts "Clean Outdated Trade"
  FootballTrade.clean_outdated
  puts "Clean outdated events"
  FootballEvent.clean_outdated
end

task :global_scrapping => :environment do
  BetclicScrapper.football_scraper
  BwinScrapper.football_scraper
  FrancepariScrapper.football_scraper
  NetbetScrapper.football_scraper
  ParionswebScrapper.football_scraper
  PmuScrapper.football_scraper
end
