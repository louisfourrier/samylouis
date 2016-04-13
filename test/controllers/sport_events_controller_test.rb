# == Schema Information
#
# Table name: sport_events
#
#  id              :integer          not null, primary key
#  event_name      :string
#  event_date      :date
#  event_time      :string
#  team_first      :string
#  team_second     :string
#  championship    :string
#  sport           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  inverse_sum     :float
#  scenario_choice :integer
#  scenario_name   :string
#

require 'test_helper'

class SportEventsControllerTest < ActionController::TestCase
  setup do
    @sport_event = sport_events(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sport_events)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sport_event" do
    assert_difference('SportEvent.count') do
      post :create, sport_event: { championship: @sport_event.championship, event_date: @sport_event.event_date, event_name: @sport_event.event_name, event_time: @sport_event.event_time, sport: @sport_event.sport, team_first: @sport_event.team_first, team_second: @sport_event.team_second }
    end

    assert_redirected_to sport_event_path(assigns(:sport_event))
  end

  test "should show sport_event" do
    get :show, id: @sport_event
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sport_event
    assert_response :success
  end

  test "should update sport_event" do
    patch :update, id: @sport_event, sport_event: { championship: @sport_event.championship, event_date: @sport_event.event_date, event_name: @sport_event.event_name, event_time: @sport_event.event_time, sport: @sport_event.sport, team_first: @sport_event.team_first, team_second: @sport_event.team_second }
    assert_redirected_to sport_event_path(assigns(:sport_event))
  end

  test "should destroy sport_event" do
    assert_difference('SportEvent.count', -1) do
      delete :destroy, id: @sport_event
    end

    assert_redirected_to sport_events_path
  end
end
