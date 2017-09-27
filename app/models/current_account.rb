class CurrentAccount < ActiveRecord::Base
  belongs_to :person
  belongs_to :account_bank
  belongs_to :cost_center
  belongs_to :sub_cost_center
  belongs_to :sub_cost_center_three
  
  #scope :ordered, -> { order(date_launche: :desc, id: :desc) }
  default_scope { order(date_launche: :desc, id: :desc) } 

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

  def self.ransackable_attributes(auth_object = nil)
    ['date_launche', 'documento', 'person_id', 'account_bank_id', 'cost_center_id', 'sub_cost_center_id', 'sub_cost_center_three_id', 'historic' ]
  end    

end
