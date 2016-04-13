class AddScenarioToSportEvents < ActiveRecord::Migration
  def change
    add_column :sport_events, :scenario_choice, :integer
    add_column :sport_events, :scenario_name, :string
  end
end
