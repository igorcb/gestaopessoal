class AccountReceivable < ActiveRecord::Base
  belongs_to :person
  belongs_to :cost_center
  belongs_to :sub_cost_center
  belongs_to :sub_cost_center_three

  has_many :lower_account_receivables

  module TypeStatus
  	ABERTO = 0
  	PAGO   = 1
  	PAGOPARCIAL = 2
  	CANCELADO = 3
  end

  def status_name
  	case self.status
  	  when 0 then "ABERTO"
  	  when 1 then "PAGO"
  	  when 2 then "PAGO_PARCIAL"
  	  when 3 then "CANCELADO"
  	end
  end  

  def saldo
    self.valor - self.lower_account_receivables.sum(:valor_pago)
  end

  def valor_total_pago
    self.lower_account_receivables.sum(:valor_pago)
  end

  def check_balance
    self.status = self.lower_account_receivables.sum(:valor_pago).to_f > 0.0 ? 
                  TypeStatus::PAGOPARCIAL : self.status = TypeStatus::ABERTO
    self.save!
  end

  def payament(options)
    #options ||= {}
    ActiveRecord::Base.transaction do
      vr_pago = options[:valor_pago].to_f + options[:juros].to_f - options[:desconto].to_f
      options.merge!(total_pago: vr_pago)

      vr_total_pago = valor_total_pago + options[:valor_pago].to_f

      if vr_total_pago >= self.valor
        self.status = TypeStatus::PAGO
      elsif vr_total_pago < self.valor
        self.status = TypeStatus::PAGOPARCIAL
      end

      self.lower_account_receivables.create!(data_pagamento: options[:data_pagamento],
                                          valor_pago: options[:valor_pago],
                                          juros: options[:juros],
                                          desconto: options[:desconto],
                                          total_pago: options[:total_pago],
                                          account_bank_id: options[:account_bank_id]
                                          )
      self.save

      CurrentAccount.create!(person_id: self.person_id, 
                            account_bank_id: options[:account_bank_id], 
                            date_launche: options[:data_pagamento],  
                            price: vr_pago,
                            type_launche: CurrentAccount::TypeLaunche::RECEITAS,
                            historic: "RECEITA: " + self.documento,
                            cost_center_id: self.cost_center_id,
                            sub_cost_center_id: self.sub_cost_center_id,
                            sub_cost_center_three_id: self.sub_cost_center_three_id
                            )
    end
  end
  

end
