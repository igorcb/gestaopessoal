class Email < ActiveRecord::Base
	belongs_to :sector
  belongs_to :person, class_name: "Person", foreign_key: "email_id", polymorphic: true, dependent: :destroy  
end
