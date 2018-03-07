class AddLicenseNoAndPhoneNumberAndEmailToEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :license_no, :string
    add_column :events, :phone_number, :string
    add_column :events, :email, :string
  end
end
