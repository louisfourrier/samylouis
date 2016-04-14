# Preview all emails at http://localhost:3000/rails/mailers/alert
class AlertPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/alert/opportunities
  def opportunities
    Alert.opportunities
  end

  # Preview this email at http://localhost:3000/rails/mailers/alert/trade_updates
  def trade_updates
    Alert.trade_updates
  end

end
