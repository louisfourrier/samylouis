# == Schema Information
#
# Table name: sport_odds
#
#  id             :integer          not null, primary key
#  sport_trade_id :integer
#  name           :string
#  value          :float
#  last_update    :datetime
#  description    :text
#  scenario_name  :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'test_helper'

class SportOddsControllerTest < ActionController::TestCase
  setup do
    @sport_odd = sport_odds(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sport_odds)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sport_odd" do
    assert_difference('SportOdd.count') do
      post :create, sport_odd: { description: @sport_odd.description, last_update: @sport_odd.last_update, name: @sport_odd.name, scenario_name: @sport_odd.scenario_name, sport_trade_id: @sport_odd.sport_trade_id, value: @sport_odd.value }
    end

    assert_redirected_to sport_odd_path(assigns(:sport_odd))
  end

  test "should show sport_odd" do
    get :show, id: @sport_odd
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sport_odd
    assert_response :success
  end

  test "should update sport_odd" do
    patch :update, id: @sport_odd, sport_odd: { description: @sport_odd.description, last_update: @sport_odd.last_update, name: @sport_odd.name, scenario_name: @sport_odd.scenario_name, sport_trade_id: @sport_odd.sport_trade_id, value: @sport_odd.value }
    assert_redirected_to sport_odd_path(assigns(:sport_odd))
  end

  test "should destroy sport_odd" do
    assert_difference('SportOdd.count', -1) do
      delete :destroy, id: @sport_odd
    end

    assert_redirected_to sport_odds_path
  end
end
