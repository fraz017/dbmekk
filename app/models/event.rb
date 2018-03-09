class Event < ApplicationRecord
  validates :title, presence: true
  validates :email, presence: true
  validates :phone_number, presence: true
  validates :license_no, presence: true
  after_create :notify_admin
  has_one :bill
  accepts_nested_attributes_for :bill, :allow_destroy => true
  attr_accessor :date_range
  scope :in_daterange, ->(start_date, end_date) { where('end > ? and start < ?', start_date, end_date) }

  def all_day_event?
    self.start == self.start.midnight && self.end == self.end.midnight ? true : false
  end
  def to_s
    license_no
  end
  def notify_admin
    ApplicationMailer.notify_event(self).deliver_now
  end
end
