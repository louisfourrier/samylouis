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
  LadbrokeScrapper.football_scrapper
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
  BetclicScrapper.basket_scrapper
end

task :all_global_scrapping => :environment do
  puts "Clean Outdated Trade"
  SportTrade.clean_outdated
  SportTrade.clean_not_linked
  SportOdd.clean_outdated
  puts "Clean outdated events"
  SportEvent.clean_outdated
  SportEvent.clean_not_linked


  puts "Scrapping on all the Bet Sites FOOTBALL"
  begin
  BetclicScrapper.football_scrapper
rescue
  puts "Betclic football scrapper error"
end
  BwinScrapper.football_scrapper
  FrancepariScrapper.football_scrapper
  NetbetScrapper.football_scrapper
  PmuScrapper.football_scrapper
  ZebetScrapper.football_scrapper
  LadbrokeScrapper.football_scrapper
  begin
  ParionswebScrapper.football_scrapper
  rescue
    puts "Parions Web football scrapper error"
  end

  UnibetScrapper.football_scrapper
  BetfirstScrapper.football_scrapper
  WinamaxScrapper.football_scrapper

  puts "Scrapping on all the Bet Sites TENNIS"
  NetbetScrapper.tennis_scrapper
  BwinScrapper.tennis_scrapper
  begin
  ParionswebScrapper.tennis_scrapper
rescue
  puts "Error parionsweb"
end
  ZebetScrapper.tennis_scrapper
  PmuScrapper.tennis_scrapper
  FrancepariScrapper.tennis_scrapper
  LadbrokeScrapper.tennis_scrapper
  begin
  BetclicScrapper.tennis_scrapper
rescue
  puts "Betclic basket scrapper error"
end
  UnibetScrapper.tennis_scrapper

  puts "Scrapping on all the Bet Sites BASKET"
  NetbetScrapper.basket_scrapper
  BwinScrapper.basket_scrapper
  begin
  ParionswebScrapper.basket_scrapper
rescue
  puts "Error parionsweb"
end
  ZebetScrapper.basket_scrapper
  PmuScrapper.basket_scrapper
  FrancepariScrapper.basket_scrapper
  LadbrokeScrapper.basket_scrapper
  UnibetScrapper.basket_scrapper
  begin
  BetclicScrapper.basket_scrapper
  rescue
    puts "Betclic basket scrapper error"
  end

  puts "Calculate Inverse Ratio"
  SportEvent.update_inverse_sum
end
