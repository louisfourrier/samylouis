class CreateFootballEvents < ActiveRecord::Migration
  def change
    create_table :football_events do |t|
      t.text :event_name
      t.date :event_date
      t.string :event_time
      t.string :team_first
      t.string :team_second
      t.string :championship

      t.timestamps null: false
    end
  end
end
