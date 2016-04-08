# == Schema Information
#
# Table name: football_trades
#
#  id                   :integer          not null, primary key
#  football_event_id    :integer
#  bet_platform_name    :string
#  bet_platform_url     :text
#  scrap_code           :text
#  team_first_name      :string
#  team_second_name     :string
#  event_date           :date
#  event_time           :string
#  first_winning_ratio  :float
#  both_winning_ratio   :float
#  second_winning_ratio :float
#  last_update          :datetime
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

require 'test_helper'

class FootballTradesControllerTest < ActionController::TestCase
  setup do
    @football_trade = football_trades(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:football_trades)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create football_trade" do
    assert_difference('FootballTrade.count') do
      post :create, football_trade: { bet_platform_name: @football_trade.bet_platform_name, bet_platform_url: @football_trade.bet_platform_url, both_winning_ratio: @football_trade.both_winning_ratio, event_date: @football_trade.event_date, event_time: @football_trade.event_time, first_winning_ratio: @football_trade.first_winning_ratio, football_event_id: @football_trade.football_event_id, last_update: @football_trade.last_update, scrap_code: @football_trade.scrap_code, second_winning_ratio: @football_trade.second_winning_ratio, team_first_name: @football_trade.team_first_name, team_second_name: @football_trade.team_second_name }
    end

    assert_redirected_to football_trade_path(assigns(:football_trade))
  end

  test "should show football_trade" do
    get :show, id: @football_trade
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @football_trade
    assert_response :success
  end

  test "should update football_trade" do
    patch :update, id: @football_trade, football_trade: { bet_platform_name: @football_trade.bet_platform_name, bet_platform_url: @football_trade.bet_platform_url, both_winning_ratio: @football_trade.both_winning_ratio, event_date: @football_trade.event_date, event_time: @football_trade.event_time, first_winning_ratio: @football_trade.first_winning_ratio, football_event_id: @football_trade.football_event_id, last_update: @football_trade.last_update, scrap_code: @football_trade.scrap_code, second_winning_ratio: @football_trade.second_winning_ratio, team_first_name: @football_trade.team_first_name, team_second_name: @football_trade.team_second_name }
    assert_redirected_to football_trade_path(assigns(:football_trade))
  end

  test "should destroy football_trade" do
    assert_difference('FootballTrade.count', -1) do
      delete :destroy, id: @football_trade
    end

    assert_redirected_to football_trades_path
  end
end
