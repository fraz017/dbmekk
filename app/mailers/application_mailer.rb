class ApplicationMailer < ActionMailer::Base
  default from: 'DBMekk<no-reply@dbmekk.no>'
  layout 'mailer'

  def notify_event(event)
    @event = event
    mail to: 'post@dbmekk.no', subject: 'New Booking alert'
  end

  def time_updated(event)
    @event = event
    mail to: @event.email, subject: 'Booking Confirmed'
  end

  def contact(data)
    @data = data
    mail to: 'post@dbmekk.no', subject: 'New Message'
  end
  def email_invoice(bill)
    @bill = bill
    attachments['invoice.pdf'] = WickedPdf.new.pdf_from_string(
      render_to_string(:pdf => "invoice", :template => 'visitors/generate_bill.html.erb', :layout => "layouts/bill.html.erb")
    )
    self.instance_variable_set(:@bill, nil)
    mail :subject => "Your Invoice", :to => "salmanshan53@gmail.com"
  end
end
