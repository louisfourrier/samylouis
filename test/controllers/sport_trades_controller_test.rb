# == Schema Information
#
# Table name: sport_trades
#
#  id              :integer          not null, primary key
#  sport_event_id  :integer
#  platform_name   :string
#  platform_url    :text
#  sport           :string
#  scenario_choice :integer
#  scenario_name   :string
#  team_first      :string
#  team_second     :string
#  event_name      :string
#  event_date      :date
#  event_time      :string
#  last_update     :datetime
#  inverse_sum     :float
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'test_helper'

class SportTradesControllerTest < ActionController::TestCase
  setup do
    @sport_trade = sport_trades(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sport_trades)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sport_trade" do
    assert_difference('SportTrade.count') do
      post :create, sport_trade: { event_date: @sport_trade.event_date, event_name: @sport_trade.event_name, event_time: @sport_trade.event_time, inverse_sum: @sport_trade.inverse_sum, last_update: @sport_trade.last_update, platform_name: @sport_trade.platform_name, platform_url: @sport_trade.platform_url, scenario_choice: @sport_trade.scenario_choice, scenario_name: @sport_trade.scenario_name, sport: @sport_trade.sport, sport_event_id: @sport_trade.sport_event_id, team_first: @sport_trade.team_first, team_second: @sport_trade.team_second }
    end

    assert_redirected_to sport_trade_path(assigns(:sport_trade))
  end

  test "should show sport_trade" do
    get :show, id: @sport_trade
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sport_trade
    assert_response :success
  end

  test "should update sport_trade" do
    patch :update, id: @sport_trade, sport_trade: { event_date: @sport_trade.event_date, event_name: @sport_trade.event_name, event_time: @sport_trade.event_time, inverse_sum: @sport_trade.inverse_sum, last_update: @sport_trade.last_update, platform_name: @sport_trade.platform_name, platform_url: @sport_trade.platform_url, scenario_choice: @sport_trade.scenario_choice, scenario_name: @sport_trade.scenario_name, sport: @sport_trade.sport, sport_event_id: @sport_trade.sport_event_id, team_first: @sport_trade.team_first, team_second: @sport_trade.team_second }
    assert_redirected_to sport_trade_path(assigns(:sport_trade))
  end

  test "should destroy sport_trade" do
    assert_difference('SportTrade.count', -1) do
      delete :destroy, id: @sport_trade
    end

    assert_redirected_to sport_trades_path
  end
end
