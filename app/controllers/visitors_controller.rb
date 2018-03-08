class VisitorsController < ApplicationController
  def index
  end
  def schedule
  end
  def generate_bill
    @bill = Bill.find params[:id]
    render layout: "bill"
  end
  def contact
    ApplicationMailer.contact(params).deliver_now
    redirect_to root_url, notice: "Your message has been submitted!"
  end
end
