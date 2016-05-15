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
  puts "Clean outdated events"
  SportEvent.clean_outdated
  SportEvent.clean_not_linked


  ################################
  ###########  Football ############
  ################################
  puts "Scrapping on all the Bet Sites FOOTBALL"
  begin
  BetclicScrapper.football_scrapper
  rescue
  puts "Betclic football scrapper error"
  end

  begin
  BwinScrapper.football_scrapper
  rescue
  puts "Bwin football scrapper error"
  end

  begin
  FrancepariScrapper.football_scrapper
  rescue
  puts "FranceParis football scrapper error"
  end

  begin
  NetbetScrapper.football_scrapper
  rescue
  puts "Netbet football scrapper error"
  end

  begin
  ParionswebScrapper.football_scrapper
  rescue
  puts "Parionsweb football scrapper error"
  end

  begin
  PmuScrapper.football_scrapper
  rescue
  puts "Pmu football scrapper error"
  end

  begin
  ZebetScrapper.football_scrapper
  rescue
  puts "Zebet football scrapper error"
  end

  begin
  LadbrokeScrapper.football_scrapper
  rescue
  puts "Ladbroke football scrapper error"
  end

  begin
  UnibetScrapper.football_scrapper
  rescue
  puts "Unibet football scrapper error"
  end

  begin
  BetfirstScrapper.football_scrapper
  rescue
  puts "Betfirst football scrapper error"
  end

  begin
  WinamaxScrapper.football_scrapper
  rescue
  puts "Winamax football scrapper error"
  end

  ################################
  ###########  Tennis ############
  ################################
  puts "Scrapping on all the Bet Sites TENNIS"

  begin
  NetbetScrapper.tennis_scrapper
  rescue
  puts "Netbet tennis scrapper error"
  end

  begin
  BwinScrapper.tennis_scrapper
  rescue
  puts "Bwin tennis scrapper error"
  end

  begin
  ParionswebScrapper.tennis_scrapper
  rescue
  puts "Parionsweb tennis scrapper error"
  end

  begin
  ZebetScrapper.tennis_scrapper
  rescue
  puts "Zebet tennis scrapper error"
  end

  begin
  PmuScrapper.tennis_scrapper
  rescue
  puts "Pmu tennis scrapper error"
  end

  begin
  FrancepariScrapper.tennis_scrapper
  rescue
  puts "FrancePari tennis scrapper error"
  end

  begin
  LadbrokeScrapper.tennis_scrapper
  rescue
  puts "Ladbroke tennis scrapper error"
  end

  begin
  BetclicScrapper.tennis_scrapper
  rescue
  puts "Betclic tennis scrapper error"
  end

  begin
  UnibetScrapper.tennis_scrapper
  rescue
  puts "Unibet tennis scrapper error"
  end

  ################################
  ###########  BASKET ############
  ################################
  puts "Scrapping on all the Bet Sites BASKET"

  begin
  NetbetScrapper.basket_scrapper
  rescue
  puts "Netbet basket scrapper error"
  end

  begin
  BwinScrapper.basket_scrapper
  rescue
  puts "Bwin basket scrapper error"
  end

  begin
  ParionswebScrapper.basket_scrapper
  rescue
  puts "ParionsWeb basket scrapper error"
  end

  begin
  ZebetScrapper.basket_scrapper
  rescue
  puts "Zebet basket scrapper error"
  end

  begin
  PmuScrapper.basket_scrapper
  rescue
  puts "Pmu basket scrapper error"
  end

  begin
  FrancepariScrapper.basket_scrapper
  rescue
  puts "Franceparis basket scrapper error"
  end

  begin
  LadbrokeScrapper.basket_scrapper
  rescue
  puts "Ladbroke basket scrapper error"
  end

  begin
  UnibetScrapper.basket_scrapper
  rescue
  puts "Unibet basket scrapper error"
  end

  begin
  BetclicScrapper.basket_scrapper
  rescue
  puts "Betclic basket scrapper error"
  end

  ########### COMPUTING INVERSE RATIOS ############
  puts "Calculate Inverse Ratio"
  SportEvent.update_inverse_sum

  puts "Everything ran"

end
