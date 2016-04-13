task :all_clean => :environment do
  puts "Clean Outdated Trade"
  SportTrade.clean_outdated
  puts "Clean outdated events"
  SportEvent.clean_outdated
  SportEvent.clean_not_linked
end

task :compute_inverse => :environment do
  puts "Calculate Inverse Ratio"
  SportEvent.update_inverse_sum
end


task :football_global_scrapping => :environment do
  puts "Scrapping on all the Bet Sites"
  BetclicScrapper.football_scrapper
  BwinScrapper.football_scrapper
  FrancepariScrapper.football_scrapper
  NetbetScrapper.football_scrapper
  ParionswebScrapper.football_scrapper
  PmuScrapper.football_scrapper
  ZebetScrapper.football_scrapper
end

task :tennis_global_scrapping => :environment do
  puts "Scrapping on all the Bet Sites"
  NetbetScrapper.tennis_scrapper
  BwinScrapper.tennis_scrapper
  ParionswebScrapper.tennis_scrapper
  ZebetScrapper.tennis_scrapper
  PmuScrapper.tennis_scrapper
  FrancepariScrapper.tennis_scrapper
  BetclicScrapper.tennis_scrapper
end

task :basket_global_scrapping => :environment do
  puts "Scrapping on all the Bet Sites"
  NetbetScrapper.basket_scrapper
  BwinScrapper.basket_scrapper
  ParionswebScrapper.basket_scrapper
  ZebetScrapper.basket_scrapper
  PmuScrapper.basket_scrapper
  FrancepariScrapper.basket_scrapper
end

task :all_global_scrapping => :environment do
  puts "Scrapping on all the Bet Sites FOOTBALL"
  BetclicScrapper.football_scrapper
  BwinScrapper.football_scrapper
  FrancepariScrapper.football_scrapper
  NetbetScrapper.football_scrapper
  ParionswebScrapper.football_scrapper
  PmuScrapper.football_scrapper
  ZebetScrapper.football_scrapper

  puts "Scrapping on all the Bet Sites TENNIS"
  NetbetScrapper.tennis_scrapper
  BwinScrapper.tennis_scrapper
  ParionswebScrapper.tennis_scrapper
  ZebetScrapper.tennis_scrapper
  PmuScrapper.tennis_scrapper
  FrancepariScrapper.tennis_scrapper
  BetclicScrapper.tennis_scrapper

  puts "Scrapping on all the Bet Sites BASKET"
  NetbetScrapper.basket_scrapper
  BwinScrapper.basket_scrapper
  ParionswebScrapper.basket_scrapper
  ZebetScrapper.basket_scrapper
  PmuScrapper.basket_scrapper
  FrancepariScrapper.basket_scrapper

  puts "Calculate Inverse Ratio"
  SportEvent.update_inverse_sum
end
