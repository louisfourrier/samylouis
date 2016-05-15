## ALL THE TASKS THAT ARE COMPATIBLE WITH PRODUCTION AND DEPLOYMENT

task :prod_all_clean => :environment do
  puts "Clean Outdated Trade"
  SportTrade.clean_outdated
  puts "Clean outdated events"
  SportEvent.clean_outdated
  SportEvent.clean_not_linked
end

task :prod_compute_inverse => :environment do
  puts "Calculate Inverse Ratio"
  SportEvent.update_inverse_sum
end


task :prod_football_global_scrapping => :environment do
  puts "Scrapping on all the Bet Sites"

  BwinScrapper.football_scrapper
  FrancepariScrapper.football_scrapper
  NetbetScrapper.football_scrapper
  ParionswebScrapper.football_scrapper
  PmuScrapper.football_scrapper
  ZebetScrapper.football_scrapper
  LadbrokeScrapper.football_scrapper

  begin
    BetclicScrapper.football_scrapper
  rescue
    puts "Pb with betclic production"
  end
end

task :tennis_global_scrapping => :environment do
  puts "Scrapping on all the Bet Sites"
  NetbetScrapper.tennis_scrapper
  BwinScrapper.tennis_scrapper
  ParionswebScrapper.tennis_scrapper
  ZebetScrapper.tennis_scrapper
  PmuScrapper.tennis_scrapper
  FrancepariScrapper.tennis_scrapper
  begin
    BetclicScrapper.tennis_scrapper
  rescue
    puts "Pb with betclic production"
  end
end

task :prod_basket_global_scrapping => :environment do
  puts "Scrapping on all the Bet Sites"
  NetbetScrapper.basket_scrapper
  BwinScrapper.basket_scrapper
  ParionswebScrapper.basket_scrapper
  ZebetScrapper.basket_scrapper
  PmuScrapper.basket_scrapper
  FrancepariScrapper.basket_scrapper
end

task :prod_all_global_scrapping => :environment do
  puts "Clean Outdated Trade"
  SportTrade.clean_outdated
  SportOdd.clean_outdated
  puts "Clean outdated events"
  SportEvent.clean_outdated
  SportEvent.clean_not_linked

  puts "Scrapping on all the Bet Sites FOOTBALL"

  BwinScrapper.football_scrapper
  FrancepariScrapper.football_scrapper
  NetbetScrapper.football_scrapper
  ParionswebScrapper.football_scrapper
  PmuScrapper.football_scrapper
  ZebetScrapper.football_scrapper
  LadbrokeScrapper.football_scrapper


  puts "Scrapping on all the Bet Sites TENNIS"
  NetbetScrapper.tennis_scrapper
  BwinScrapper.tennis_scrapper
  ParionswebScrapper.tennis_scrapper
  ZebetScrapper.tennis_scrapper
  PmuScrapper.tennis_scrapper
  FrancepariScrapper.tennis_scrapper
  LadbrokeScrapper.tennis_scrapper

  puts "Scrapping on all the Bet Sites BASKET"
  NetbetScrapper.basket_scrapper
  BwinScrapper.basket_scrapper
  # Parions Web has a Three odd based basket program => Cause pb with the odds
  #ParionswebScrapper.basket_scrapper
  ZebetScrapper.basket_scrapper
  PmuScrapper.basket_scrapper
  FrancepariScrapper.basket_scrapper
  LadbrokeScrapper.basket_scrapper

  begin
    BetclicScrapper.football_scrapper
    BetclicScrapper.tennis_scrapper
  rescue
    puts "Problem with Betclic on production"
  end

  puts "Calculate Inverse Ratio"
  SportEvent.update_inverse_sum
  SportEvent.email_opportunities
end
