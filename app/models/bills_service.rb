class BillsService < ApplicationRecord
  belongs_to :bill
  belongs_to :service
  after_save :add_price

  def add_price
    self.service.grand_total = self.service.price
    if self.discount.present?
      self.service.grand_total = self.service.grand_total-(self.service.grand_total*self.discount/100)
      self.service.save
    end
  end
end
