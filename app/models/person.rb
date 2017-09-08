class Person < ActiveRecord::Base

	module TypePerson
		PESSOA_FISICA = 0
		PESSOA_JURIDICA = 1
	end

	def name_type_person
		case self.tipo_pessoa
			when 0 then "CPF"
			when 1 then "CNPJ"
		end
	end
end
