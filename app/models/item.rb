class Item < ApplicationRecord
  belongs_to :bill, optional: true
  validates :name, presence: true
  validates :price, presence: true
  before_save :add_price

  def add_price
    self.grand_total = self.price + (self.price*(self.tax/100.0))
  end
end
