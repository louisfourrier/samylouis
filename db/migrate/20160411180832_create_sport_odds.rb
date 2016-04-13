class CreateSportOdds < ActiveRecord::Migration
  def change
    create_table :sport_odds do |t|
      t.references :sport_trade, index: true, foreign_key: true
      t.string :name
      t.float :value
      t.datetime :last_update
      t.text :description
      t.string :scenario_name

      t.timestamps null: false
    end
  end
end
