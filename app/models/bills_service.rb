class BillsService < ApplicationRecord
  belongs_to :bill
  belongs_to :service
  before_save :add_price

  def add_price
    self.discounted_net = self.service.price
    self.discounted_price = self.service.grand_total
    if self.discount.present?
      self.discounted_price = self.service.grand_total-(self.service.grand_total*self.discount/100)
      self.discounted_net = self.service.price-(self.service.price*self.discount/100)
    end
  end
end
