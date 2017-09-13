class AccountBank < ActiveRecord::Base

  def saldo(date=nil)
    date.nil? ? CurrentAccount.where(account_bank_id: self.id).sum('price*type_launche') : CurrentAccount.where(account_bank_id: self.id, date_ocurrence: date).sum('price*type_launche')
  end

end
