class CurrentAccount < ActiveRecord::Base
  belongs_to :account_bank
  belongs_to :cost_center
  belongs_to :sub_cost_center
  belongs_to :sub_cost_center_three

  module TypeLaunche
  	DESPESAS = -1
  	RECEITAS = 1
  end

  def name_type_launche
  	case self.type_launche
	  	when -1 then 'DESPESAS'
	  	when  1 then 'RECEITAS'
  	end
  end
end
