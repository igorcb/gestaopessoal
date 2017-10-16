module ApplicationHelper
  def full_title(page_title)
    base_title = "L7 Logística"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end	
	
  def select_credito_debito
    ([['Despesas', -1], ['Receitas', 1]])
  end  

  def date_br(date)
    date.nil? ? "" : I18n.l(date, format: '%d/%m/%Y')
  end

  def select_uf
    ([["AC","AC"],["AL","AL"],["AM","AM"],["AP","AP"],["BA","BA"],["CE","CE"],["DF","DF"],["ES","ES"],  
    ["GO","GO"],["MA","MA"],["MG","MG"],["MS","MS"],["MT","MT"],["PA","PA"],["PB","PB"],["PE","PE"],["PI","PI"],["PR","PR"],  
    ["RJ","RJ"],["RN","RN"],["RO","RO"],["RR","RR"],["RS","RS"],["SC","SC"],["SE","SE"],["SP","SP"],["TO","TO"]])
  end  
end


# 001 - Conta Corrente - P.Física
# 002 - Conta Simples - P.Física
# 003 - Conta Corrente - P.Jurídica
# 006 - Entidades Públicas
# 013 - Poupança
# 022 - Poupança - Pessoa Jurídica
# 023 - Conta CAIXA Fácil
# 028 - Poupança Crédito Imobiliário