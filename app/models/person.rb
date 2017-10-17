class Person < ActiveRecord::Base

  has_many :contacts, class_name: "Contact", foreign_key: "contact_id", :as => :contact, dependent: :destroy
  accepts_nested_attributes_for :contacts, allow_destroy: true

  has_many :emails, class_name: "Email", foreign_key: "email_id", :as => :email, dependent: :destroy
  accepts_nested_attributes_for :emails, allow_destroy: true  

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
