class CreateTennisTrades < ActiveRecord::Migration
  def change
    create_table :tennis_trades do |t|
      t.string :bet_platform_name
      t.text :bet_platform_url
      t.string :team_first_name
      t.string :team_second_name
      t.date :event_date
      t.string :event_time
      t.float :first_ratio
      t.float :second_ratio
      t.references :sport_event, index: true, foreign_key: true
      t.datetime :last_update

      t.timestamps null: false
    end
  end
end
