class CreateLowerAccountReceivables < ActiveRecord::Migration
  def change
    create_table :lower_account_receivables do |t|
      t.references :account_receivable, index: true
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
