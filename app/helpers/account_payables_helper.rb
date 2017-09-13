module AccountPayablesHelper

  def select_status_payables
     ([["ABERTO", 0], ["PAGO PARCIAL", 1], ["PAGO", 2]])
  end
  
end
