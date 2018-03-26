class Item < ApplicationRecord
  belongs_to :bill, optional: true
  validates :name, presence: true
  validates :price, presence: true
  before_save :add_price

  def add_price
    self.grand_total = self.price
    if self.discount.present?
      self.grand_total = self.price-(self.price*self.discount/100)
    end
  end
end
