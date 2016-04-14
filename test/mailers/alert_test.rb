require 'test_helper'

class AlertTest < ActionMailer::TestCase
  test "opportunities" do
    mail = Alert.opportunities
    assert_equal "Opportunities", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "trade_updates" do
    mail = Alert.trade_updates
    assert_equal "Trade updates", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
