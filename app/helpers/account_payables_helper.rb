module AccountPayablesHelper

  def select_status_payables
     ([["ABERTO", 0], ["PAGO", 1], ["PAGO PARCIAL", 2]])
  end
  
end
