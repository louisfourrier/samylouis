class AlertMailer < ApplicationMailer
  default reply_to: "SamyLouis BetBot <samylouisbot@betbot.com>"
  default from: "SamyLouis BetBot <samylouisbot@betbot.com>"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.alert.opportunities.subject
  #
  def opportunities(sport_events)
    @sport_events = sport_events
    subject = @sport_events.count.to_s + " Opportunités de pari détectées !"
    mail to: "louis.fourrier@gmail.com, samy.jazaerli@gmail.com", subject: subject
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
