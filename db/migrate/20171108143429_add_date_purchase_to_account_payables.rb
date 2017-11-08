class AddDatePurchaseToAccountPayables < ActiveRecord::Migration
  def change
    add_column :account_payables, :date_purchase, :date
  end
end
