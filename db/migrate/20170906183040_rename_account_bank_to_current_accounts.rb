class RenameAccountBankToCurrentAccounts < ActiveRecord::Migration
	def change
    rename_column :current_accounts, :account_banck_id, :account_bank_id
  end
end
