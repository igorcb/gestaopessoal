class CreateCurrentAccounts < ActiveRecord::Migration
  def change
    create_table :current_accounts do |t|
      t.references :account_banck, index: true, foreign_key: true
      t.references :cost_center, index: true, foreign_key: true
      t.references :sub_cost_center, index: true, foreign_key: true
      t.references :sub_cost_center_three, index: true, foreign_key: true
      t.string :nome
      t.date :date_launche
      t.integer :type_launche
      t.decimal :price
      t.text :historic

      t.timestamps null: false
    end
  end
end
