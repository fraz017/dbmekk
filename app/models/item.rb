class Item < ApplicationRecord
  belongs_to :bill, optional: true
  validates :name, presence: true
  validates :price, presence: true
  before_save :add_price

  def add_price
    self.grand_total = self.price
    self.discounted_price = self.grand_total
    # self.price = self.price.to_f - (self.price * 25/100).round(2)
    self.discounted_net = self.price.to_f - (self.price * 25/100).round(2)
    if self.discount.present?
      self.discounted_price = self.grand_total.to_f - (self.grand_total*self.discount/100).round(2)
      # self.discounted_net = self.discounted_net.to_f - (self.discounted_net*self.discount/100).round(2)
    end
  end
end
