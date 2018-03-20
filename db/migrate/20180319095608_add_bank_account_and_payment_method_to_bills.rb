class AddBankAccountAndPaymentMethodToBills < ActiveRecord::Migration[5.1]
  def change
    add_column :bills, :bank_account, :string
    add_column :bills, :payment_method, :string
  end
end
