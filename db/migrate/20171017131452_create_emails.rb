class CreateEmails < ActiveRecord::Migration
  def change
    create_table :emails do |t|
      t.references :sector, index: true
      t.string :contato, limit: 60, null: false
      t.string :email, limit: 100, null: false
      t.string :observation, limit: 40, null: false
      t.integer :email_id, index: true
      t.string :email_type, index: true

      t.timestamps
    end
  end
end