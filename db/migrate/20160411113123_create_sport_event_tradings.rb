class CreateSportEventTradings < ActiveRecord::Migration
  def change
    create_table :sport_event_tradings do |t|
      t.references :sport_event, index: true, foreign_key: true
      t.references :sport_trade, polymorphic: true
      t.timestamps null: false
    end
  end
end
