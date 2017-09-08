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
end


# 001 - Conta Corrente - P.Física
# 002 - Conta Simples - P.Física
# 003 - Conta Corrente - P.Jurídica
# 006 - Entidades Públicas
# 013 - Poupança
# 022 - Poupança - Pessoa Jurídica
# 023 - Conta CAIXA Fácil
# 028 - Poupança Crédito Imobiliário