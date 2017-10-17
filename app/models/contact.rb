class Contact < ActiveRecord::Base
  validates :tipo, presence: true
  validates :nome, presence: true,  length: { maximum: 30 }
  #validates :fone, presence: true

  belongs_to :person, class_name: "Person", foreign_key: "contact_id", polymorphic: true, dependent: :destroy	

	module TipoContato
		FIXO     = 0
		CELULAR  = 1
		EMAIL    = 2
		TWITTER  = 3
		FACEBOOK = 4
		RESPONSAVEL_CARGA = 5
		RESPONSAVEL_PALETE = 6
	end

	def tipo_contato
		case self.tipo
		  when 0 then "Fixo"
		  when 1 then "Celular"
		  when 2 then "Email"
			when 3 then "Twitter"
			when 4 then "Facebook"
			when 5 then "Responsavel pela Carga"
			when 6 then "Responsavel pelo Palete"
		end
		
	end  
end
