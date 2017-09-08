class CreateSubCostCenterThrees < ActiveRecord::Migration
  def change
    create_table :sub_cost_center_threes do |t|
      t.references :cost_center, index: true, foreign_key: true
      t.references :sub_cost_center, index: true, foreign_key: true
      t.string :nome

      t.timestamps null: false
    end
  end
end
