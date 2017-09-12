class CreateAccountReceivables < ActiveRecord::Migration
  def change
    create_table :account_receivables do |t|
      t.references :person, index: true
      t.references :cost_center, index: true
      t.references :sub_cost_center, index: true
      t.references :sub_cost_center_three, index: true
      t.date :data_vencimento
      t.string :documento
      t.decimal :valor, precision: 10, scale: 2
      t.text :obs
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
