class VisitorsController < ApplicationController
  layout "bill", only: [:generate_bill]

  def index
  end

  def schedule
  end

  def generate_bill
    @bill = Bill.find params[:id]
    respond_to do |format|
      format.html
      format.pdf do
        render :pdf => "file.pdf", :template => "visitors/generate_bill.html.erb", :layout => "layouts/bill.html.erb", :show_as_html => params[:debug].present? #footer: { html: {:template => "visitors/footer.html.erb"} }, view_as_html: true
      end
    end
  end

  def contact
    ApplicationMailer.contact(params).deliver_now
    respond_to do |format|
      format.js
    end
    # redirect_to root_url, notice: "Your message has been submitted!"
  end
end
