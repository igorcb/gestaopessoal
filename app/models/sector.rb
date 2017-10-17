class Sector < ActiveRecord::Base
  validates :name, presence: true,  length: { maximum: 50 }
	has_many :emails
end
