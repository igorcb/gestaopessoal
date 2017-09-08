class CreateAccountBanks < ActiveRecord::Migration
  def change
    create_table :account_banks do |t|
      t.string :nome
      t.string :agencia
      t.string :conta
      t.string :tipo

      t.timestamps null: false
    end
  end
end
