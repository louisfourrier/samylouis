class CreateFootballTrades < ActiveRecord::Migration
  def change
    create_table :football_trades do |t|
      t.references :football_event, index: true, foreign_key: true
      t.string :bet_platform_name
      t.text :bet_platform_url
      t.text :scrap_code
      t.string :team_first_name
      t.string :team_second_name
      t.date :event_date
      t.string :event_time
      t.float :first_winning_ratio
      t.float :both_winning_ratio
      t.float :second_winning_ratio
      t.datetime :last_update

      t.timestamps null: false
    end
  end
end
