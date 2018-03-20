class Service < ApplicationRecord
  validates :name, presence: true
  validates :price, presence: true
  has_many :bills_services, :dependent => :destroy
  has_many :bills, through: :bills_services
  # before_save :add_price

  # def add_price
  #   self.grand_total = self.price + (self.price*(self.tax/100.0))
  #   begin
  #     discount = BillsService.where(bill_id: self.bill.id, service_id: self.id).first.discount
  #     self.grand_total = self.price + (self.price*(discount/100.0))
  #   rescue
  #   end
  # end
end
