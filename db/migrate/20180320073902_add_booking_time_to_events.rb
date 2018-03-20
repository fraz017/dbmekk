class AddBookingTimeToEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :booking_time, :time
  end
end
