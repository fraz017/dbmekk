class VisitorsController < ApplicationController
  def index
  end
  def schedule
  end
  def generate_bill
    @bill = Bill.find params[:id]
    render layout: "bill"
  end
end
