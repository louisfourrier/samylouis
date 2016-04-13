class CreateSportTrades < ActiveRecord::Migration
  def change
    create_table :sport_trades do |t|
      t.references :sport_event, index: true, foreign_key: true
      t.string :platform_name
      t.text :platform_url
      t.string :sport
      t.integer :scenario_choice
      t.string :scenario_name
      t.string :team_first
      t.string :team_second
      t.string :event_name
      t.date :event_date
      t.string :event_time
      t.datetime :last_update
      t.float :inverse_sum

      t.timestamps null: false
    end
  end
end
