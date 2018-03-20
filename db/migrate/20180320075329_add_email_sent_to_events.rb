class AddEmailSentToEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :email_sent, :boolean
  end
end
