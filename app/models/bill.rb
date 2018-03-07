class Bill < ApplicationRecord
  belongs_to :event, optional: true
  has_and_belongs_to_many :services, optional: true
  has_many :items
  accepts_nested_attributes_for :services, :allow_destroy => true
  accepts_nested_attributes_for :items, :allow_destroy => true
  after_save :change_price

  def sub_total
    items.sum(:price) + services.sum(:price)
  end

  def grand_total
    items.sum(:grand_total) + services.sum(:grand_total)
  end

  def cal_tax
    (sub_total * 25)/100
  end

  private
  def change_price
    self.update_columns(tax: cal_tax, price: sub_total, grand_total: grand_total)
  end
end
