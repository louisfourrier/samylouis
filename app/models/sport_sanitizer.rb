# Class that will define the rules to sanitize the names of sport teams
class SportSanitizer

  # Rules and String changes for football teams
  def self.football_team_sanitizer(team)
    new_team = team.gsub('fc ', '')
    new_team = new_team.gsub('sd ', '')
    new_team = new_team.gsub('as ', '')
    new_team = new_team.gsub('sd ', '')
    new_team = new_team.gsub(' fc', '')
    new_team = new_team.gsub('vfl ', '')
    new_team = new_team.gsub('ogc ', '')
    new_team = new_team.gsub(' cf', '')
  end


end
