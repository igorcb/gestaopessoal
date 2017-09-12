class LowerAccountReceivable < ActiveRecord::Base
  belongs_to :account_receivable
  belongs_to :account_bank

  before_destroy :back_balance

  private
  	def back_balance
  		ActiveRecord::Base.transaction do
  			data = Time.now.strftime('%Y-%m-%d')
  			account = self.account_receivable
  			if self.account_bank.present?
		      CurrentAccount.create!(person_id: self.account_receivable.person_id, 
                           account_bank_id: self.account_bank_id, 
                              date_launche: self.data_pagamento,  
                                     price: self.total_pago,
                              type_launche: CurrentAccount::TypeLaunche::DESPESAS,
                                  historic: "ESTORNO DE RECEBIMENTO: " + self.account_receivable.obs,
                            cost_center_id: self.account_receivable.cost_center_id,
                        sub_cost_center_id: self.account_receivable.sub_cost_center_id,
                  sub_cost_center_three_id: self.account_receivable.sub_cost_center_three_id
                            )

	      end
  		end
  	end

end
