class Event < ApplicationRecord
  validates :title, presence: true
  # validates :email, presence: true
  validates :phone_number, presence: true
  validates :license_no, presence: true
  # after_create :notify_admin
  has_one :bill
  validates_format_of :email, :with => Devise::email_regexp, message: "Invalid Email"
  accepts_nested_attributes_for :bill, :allow_destroy => true
  attr_accessor :date_range
  scope :in_daterange, -> (start_date, end_date) { where('end > ? and start < ?', start_date, end_date) }

  # after_update :send_email

  def send_email
    if booking_time_changed? && !email_sent?
      ApplicationMailer.time_updated(self).deliver_now
      update_attribute :email_sent, true
    end
  end

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
