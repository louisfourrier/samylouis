class AddInverseSumRatioToEvents < ActiveRecord::Migration
  def change
    add_column :football_events, :inverse_sum, :float
    add_column :sport_events, :inverse_sum, :float
  end
end
