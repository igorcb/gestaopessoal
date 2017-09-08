class AddPersonToCurrentAccounts < ActiveRecord::Migration
  def change
    add_reference :current_accounts, :person, index: true
  end
end
