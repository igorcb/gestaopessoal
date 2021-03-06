class CreateLowerAccountPayables < ActiveRecord::Migration
  def change
    create_table :lower_account_payables do |t|
      t.references :account_payable, index: true
      t.references :account_bank, index: true
      t.date :data_pagamento
      t.decimal :valor_pago, precision: 10, scale: 2
      t.decimal :juros, precision: 10, scale: 2
      t.decimal :desconto, precision: 10, scale: 2
      t.decimal :total_pago, precision: 10, scale: 2

      t.timestamps
    end
  end
end
