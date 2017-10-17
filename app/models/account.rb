class Account < ActiveRecord::Base
  belongs_to :bank
  belongs_to :person, class_name: "Person", foreign_key: "account_id", polymorphic: true, dependent: :destroy
end
