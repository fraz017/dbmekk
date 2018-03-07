class Service < ApplicationRecord
  validates :name, presence: true
  validates :price, presence: true
  has_and_belongs_to_many :bills, optional: true
  before_save :add_price

  def add_price
    self.grand_total = self.price + (self.price*(self.tax/100.0))
  end
end
