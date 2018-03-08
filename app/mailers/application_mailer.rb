class ApplicationMailer < ActionMailer::Base
  default from: 'no-reply@dbmekk.no'
  layout 'mailer'

  def notify_event(event)
    @event = event
    mail to: 'salmanshan53@gmail.com', subject: 'New Booking alert'
  end
end
