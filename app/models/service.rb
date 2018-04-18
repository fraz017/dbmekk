class Service < ApplicationRecord
  validates :name, presence: true
  validates :price, presence: true
  has_many :bills_services, :dependent => :destroy
  has_many :bills, through: :bills_services

  before_save :set_grand_total

  def set_grand_total
    self.grand_total = self.price
    self.price = self.price.to_f - ((self.price * 25) / 100).round(2) 
  end
end
