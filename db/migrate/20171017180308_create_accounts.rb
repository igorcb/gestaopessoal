class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.references :bank, index: true
      t.string  :agencia
      t.string  :conta
      t.string  :tipo
      t.string  :favorecido
      t.string  :cpf_cnpj
      t.string  :observation
      t.integer :account_id, index: true
      t.string  :account_type

      t.timestamps
    end
  end
end
