# == Schema Information
#
# Table name: football_events
#
#  id           :integer          not null, primary key
#  event_name   :text
#  event_date   :date
#  event_time   :string
#  team_first   :string
#  team_second  :string
#  championship :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  inverse_sum  :float
#

require 'test_helper'

class FootballEventsControllerTest < ActionController::TestCase
  setup do
    @football_event = football_events(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:football_events)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create football_event" do
    assert_difference('FootballEvent.count') do
      post :create, football_event: { championship: @football_event.championship, event_date: @football_event.event_date, event_name: @football_event.event_name, event_time: @football_event.event_time, team_first: @football_event.team_first, team_second: @football_event.team_second }
    end

    assert_redirected_to football_event_path(assigns(:football_event))
  end

  test "should show football_event" do
    get :show, id: @football_event
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @football_event
    assert_response :success
  end

  test "should update football_event" do
    patch :update, id: @football_event, football_event: { championship: @football_event.championship, event_date: @football_event.event_date, event_name: @football_event.event_name, event_time: @football_event.event_time, team_first: @football_event.team_first, team_second: @football_event.team_second }
    assert_redirected_to football_event_path(assigns(:football_event))
  end

  test "should destroy football_event" do
    assert_difference('FootballEvent.count', -1) do
      delete :destroy, id: @football_event
    end

    assert_redirected_to football_events_path
  end
end
