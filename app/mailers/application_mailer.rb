class ApplicationMailer < ActionMailer::Base
  default from: 'no-reply@dbmekk.no'
  layout 'mailer'

  def notify_event(event)
    @event = event
    mail to: 'Jacob@dbmekk.no', subject: 'New Booking alert'
  end
  def time_updated(event)
    @event = event
    mail to: @event.email, subject: 'Booking time updated'
  end
  def contact(data)
    @data = data
    mail to: 'Jacob@dbmekk.no', subject: 'New Message'
  end
end
