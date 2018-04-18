class Bill < ApplicationRecord
  belongs_to :event, optional: true
  has_many :bills_services, :dependent => :destroy
  has_many :services, through: :bills_services
  has_many :items
  accepts_nested_attributes_for :bills_services, :allow_destroy => true
  accepts_nested_attributes_for :items, :allow_destroy => true
  after_save :change_price

  def bill_number
    "DBM-" + self.id.to_s.rjust(6, '0')
  end

  def grand_total
    items.sum(:discounted_price) + services.sum(:discounted_price)
  end

  def sub_total
    # items.sum(:discounted_net) + services.sum(:discounted_net)
    (grand_total - (grand_total * 25)/100)
  end


  def cal_tax
    (grand_total * 25)/100
  end

  private
  def change_price
    self.update_columns(tax: cal_tax, price: sub_total, grand_total: grand_total)
    if self.payment_method == "Email"
      ApplicationMailer.email_invoice(self).deliver_now
    end
  end
end
