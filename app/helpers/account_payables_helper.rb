module AccountPayablesHelper

  def select_status_payables
     ([["ABERTO", 0], ["PAGO", 1], ["PAGO PARCIAL", 2]])
  end

  def sub_center(cost_center)
    SubCostCenter.where("cost_center_id = ?", cost_center)
  end

  def sub_center_there(cost_center, sub_center)
   sub = SubCostCenterThree.where("cost_center_id = ? and sub_cost_center_id = ? ", cost_center, sub_center)
   sub.nil? ? 0 : sub
  end
end
