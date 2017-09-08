class AccountPayable < ActiveRecord::Base
  belongs_to :person
  belongs_to :cost_center
  belongs_to :sub_cost_center
  belongs_to :sub_cost_center_three

  module TypeStatus
  	ABERTO = 0
  	PAGO   = 1
  	PAGO_PARCIAL = 2
  	CANCELADO = 3
  end

  def status_name
  	case self.status
  	  when 0 then "Aberto"
  	  when 1 then "PAGO"
  	  when 2 then "PAGO_PARCIAL"
  	  when 3 then "CANCELADO"
  	end
  end
end

