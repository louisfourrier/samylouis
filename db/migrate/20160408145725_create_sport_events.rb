class CreateSportEvents < ActiveRecord::Migration
  def change
    create_table :sport_events do |t|
      t.string :event_name
      t.date :event_date
      t.string :event_time
      t.string :team_first
      t.string :team_second
      t.string :championship
      t.string :sport

      t.timestamps null: false
    end
  end
end
