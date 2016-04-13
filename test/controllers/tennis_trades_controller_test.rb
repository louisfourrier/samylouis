# == Schema Information
#
# Table name: tennis_trades
#
#  id                :integer          not null, primary key
#  bet_platform_name :string
#  bet_platform_url  :text
#  team_first_name   :string
#  team_second_name  :string
#  event_date        :date
#  event_time        :string
#  first_ratio       :float
#  second_ratio      :float
#  sport_event_id    :integer
#  last_update       :datetime
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

require 'test_helper'

class TennisTradesControllerTest < ActionController::TestCase
  setup do
    @tennis_trade = tennis_trades(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tennis_trades)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tennis_trade" do
    assert_difference('TennisTrade.count') do
      post :create, tennis_trade: { bet_platform_name: @tennis_trade.bet_platform_name, bet_platform_url: @tennis_trade.bet_platform_url, event_date: @tennis_trade.event_date, event_time: @tennis_trade.event_time, first_ratio: @tennis_trade.first_ratio, last_update: @tennis_trade.last_update, second_ratio: @tennis_trade.second_ratio, sport_event_id: @tennis_trade.sport_event_id, team_first_name: @tennis_trade.team_first_name, team_second_name: @tennis_trade.team_second_name }
    end

    assert_redirected_to tennis_trade_path(assigns(:tennis_trade))
  end

  test "should show tennis_trade" do
    get :show, id: @tennis_trade
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tennis_trade
    assert_response :success
  end

  test "should update tennis_trade" do
    patch :update, id: @tennis_trade, tennis_trade: { bet_platform_name: @tennis_trade.bet_platform_name, bet_platform_url: @tennis_trade.bet_platform_url, event_date: @tennis_trade.event_date, event_time: @tennis_trade.event_time, first_ratio: @tennis_trade.first_ratio, last_update: @tennis_trade.last_update, second_ratio: @tennis_trade.second_ratio, sport_event_id: @tennis_trade.sport_event_id, team_first_name: @tennis_trade.team_first_name, team_second_name: @tennis_trade.team_second_name }
    assert_redirected_to tennis_trade_path(assigns(:tennis_trade))
  end

  test "should destroy tennis_trade" do
    assert_difference('TennisTrade.count', -1) do
      delete :destroy, id: @tennis_trade
    end

    assert_redirected_to tennis_trades_path
  end
end
