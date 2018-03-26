class Service < ApplicationRecord
  validates :name, presence: true
  validates :price, presence: true
  has_many :bills_services, :dependent => :destroy
  has_many :bills, through: :bills_services
end
