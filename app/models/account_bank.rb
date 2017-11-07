class AccountBank < ActiveRecord::Base

  def saldo(date=nil)
    date.nil? ? CurrentAccount.where(account_bank_id: self.id).sum('price*type_launche') : CurrentAccount.where(account_bank_id: self.id, date_ocurrence: date).sum('price*type_launche')
  end

  def tranfer(accounts = {})
  	ActiveRecord::Base.transaction do
  		#Debitar da Origem
  		CurrentAccount.create!(
				 account_bank_id: accounts[:account_bank_id],
				 person_id: accounts[:person_id],
				 cost_center_id: CurrentAccount::COSTCENTER, 
				 sub_cost_center_id: CurrentAccount::SUBCOSTCENTER, 
				 sub_cost_center_three_id: CurrentAccount::SUBCOSTCENTERTHREE, 
				 type_launche: CurrentAccount::TypeLaunche::DESPESAS,
				 date_launche: accounts[:date_launche],
				 price: accounts[:price], 
				 historic: accounts[:historic]
				 )
  		#Creditar da Origem
  		CurrentAccount.create!(
				 account_bank_id: accounts[:account_bank_target_id],
				 person_id: accounts[:person_id],
				 cost_center_id: CurrentAccount::COSTCENTER, 
				 sub_cost_center_id: CurrentAccount::SUBCOSTCENTER, 
				 sub_cost_center_three_id: CurrentAccount::SUBCOSTCENTERTHREE, 
				 type_launche: CurrentAccount::TypeLaunche::RECEITAS,
				 date_launche: accounts[:date_launche],
				 price: accounts[:price], 
				 historic: accounts[:historic]
				 )
  	end
  end

end


 # id: nil, 
 # account_bank_id: nil, 
 # cost_center_id: nil, 
 # sub_cost_center_id: nil, 
 # sub_cost_center_three_id: nil, 
 # nome: nil,
 # date_launche: nil, 
 # type_launche: nil, 
 # price: nil, 
 # historic: nil, 
 # created_at: nil,
 # updated_at: nil, 
 # person_id: nil
