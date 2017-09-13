class LowerAccountPayable < ActiveRecord::Base
  belongs_to :account_payable
  belongs_to :account_bank

  before_destroy :back_balance

  private
  	def back_balance
  		ActiveRecord::Base.transaction do
  			data = Time.now.strftime('%Y-%m-%d')
  			account = self.account_payable
  			if self.account_bank.present?
		      CurrentAccount.create!(person_id: self.account_payable.person_id, 
                           account_bank_id: self.account_bank_id, 
                              date_launche: self.data_pagamento,  
                                     price: self.total_pago,
                              type_launche: CurrentAccount::TypeLaunche::RECEITAS,
                                  historic: "ESTORNO PAGAMENTO: " + self.account_payable.documento,
                            cost_center_id: self.account_payable.cost_center_id,
                        sub_cost_center_id: self.account_payable.sub_cost_center_id,
                  sub_cost_center_three_id: self.account_payable.sub_cost_center_three_id
                            )

	      end
  		end
  	end

end