class AccountPayable < ActiveRecord::Base
  validates :person_id, presence: true
  validates :date_purchase, presence: true
  validates :data_vencimento, presence: true
  validates :valor, presence: true
  validates :cost_center_id , presence: true
  validates :sub_cost_center_id, presence: true
  validates :sub_cost_center_three_id, presence: true
  #validates :status

  belongs_to :person
  belongs_to :cost_center
  belongs_to :sub_cost_center
  belongs_to :sub_cost_center_three

  has_many :lower_account_payables

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

  def self.ransackable_attributes(auth_object = nil)
    ['data_vencimento', 'documento', 'person_id', 'status' ]
  end  

  def saldo
    self.valor - self.lower_account_payables.sum(:valor_pago)
  end

  def valor_total_pago
    self.lower_account_payables.sum(:valor_pago)
  end

  def check_balance
    self.status = self.lower_account_payables.sum(:valor_pago).to_f > 0.0 ? 
                  TypeStatus::PAGOPARCIAL : self.status = TypeStatus::ABERTO
    self.save!
  end

  def self.payament_all(ids, value, account_bank)
    data = Time.now.strftime('%Y-%m-%d')
    valor_total = 0
    hash_ids = []
    ids.each do |i|
      hash_ids << i[0].to_i
      valor_total += i[1].to_f
      # Efetuar Faturamento
      id = i[0].to_i
      valor = i[1].to_f
      ActiveRecord::Base.transaction do
        account = AccountPayable.find(id)
        account.payament({data_pagamento: data, valor_pago: account.valor.to_f, juros: 0.0, desconto: 0.0, account_bank_id: account_bank})
      end
    end
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

      self.lower_account_payables.create!(data_pagamento: options[:data_pagamento],
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
                            type_launche: CurrentAccount::TypeLaunche::DESPESAS,
                            historic: "BAIXA CONTA A PAGAR: " + self.documento,
                            cost_center_id: self.cost_center_id,
                            sub_cost_center_id: self.sub_cost_center_id,
                            sub_cost_center_three_id: self.sub_cost_center_three_id
                            )
    end
  end

  def self.generate_parts(accounts = {})
    dia_vencimento = accounts[:dia_do_vencimento].present? ? accounts[:dia_do_vencimento].to_i : 0
    intervalo_parcelas = accounts[:intervalo_parcelas].present? ? accounts[:intervalo_parcelas].to_i : 0
    valor = accounts[:valor].to_f
    qtde_parcelas = accounts[:qtde_parcelas].to_i
    contador = 0
    vencimento = Date.parse(accounts[:data_vencimento])
    ActiveRecord::Base.transaction do
      valor_parcela = valor / qtde_parcelas
      novo_valor_parcela = ActiveSupport::NumberHelper.number_to_currency(valor_parcela, unit: '', delimiter: '', separator: '.', precision: 2)
      puts ">>>>>>>>>>>>>>>> Novo Valor: #{novo_valor_parcela}"
      AccountPayable.create!(person_id: accounts[:person_id], 
                            date_purchase: accounts[:data_compra],  
                            data_vencimento: accounts[:data_vencimento],  
                            valor: novo_valor_parcela,
                            documento: accounts[:documento] + " Parc: #{1}/#{qtde_parcelas}",
                            cost_center_id: accounts[:cost_center_id],
                            sub_cost_center_id: accounts[:sub_cost_center_id],
                            sub_cost_center_three_id: accounts[:sub_cost_center_three_id],
                            obs: accounts[:obs],
                            status: TypeStatus::ABERTO
                            )

      qtde_parcelas = qtde_parcelas - 1
      contador = contador + 1

      qtde_parcelas.times do |x|
        contador = contador + 1
        if dia_vencimento > 0
          vencimento = vencimento + 1.month
          month = vencimento.month
          year  = vencimento.year
          day   = dia_vencimento
          if month == 2 && dia_vencimento > 28 #FEVEREIRO get last day month
            day = vencimento.end_of_month.day
          else
            day = dia_vencimento
          end

          novo_vencimento = Date.new(year, month, day)
          
        else
          novo_vencimento = vencimento + intervalo_parcelas.days
          #puts ">>>>>>>>>>>>>>>> Venc: #{novo_vencimento}     IntDias: #{intervalo_parcelas}"
          vencimento = novo_vencimento
        end
        AccountPayable.create!(person_id: accounts[:person_id], 
                              date_purchase: accounts[:data_compra],  
                              data_vencimento: novo_vencimento,  
                              valor: valor_parcela, 
                              documento: accounts[:documento] + " Parc: #{contador}/#{accounts[:qtde_parcelas]}",
                              cost_center_id: accounts[:cost_center_id],
                              sub_cost_center_id: accounts[:sub_cost_center_id],
                              sub_cost_center_three_id: accounts[:sub_cost_center_three_id],
                              obs: accounts[:obs],
                              status: TypeStatus::ABERTO
                              )
      end
    end
  end


end

