class AlertMailer < ApplicationMailer
  default reply_to: "SamyLouis BetBot <louis.fourrier@gmail.com>"
  default from: "SamyLouis BetBot <louis.fourrier@gmail.com>"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.alert.opportunities.subject
  #
  def opportunities(sport_events)
    @sport_events = sport_events
    mail to: "louis.fourrier@gmail.com", subject: "Opportunités de pari détectées !"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.alert.trade_updates.subject
  #
  def trade_updates(date)
    @update_date = date
    mail to: "louis.fourrier@gmail.com", subject: "Mise à jour des trades sur le serveur !"
  end
end
