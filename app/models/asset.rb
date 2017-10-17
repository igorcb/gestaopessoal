class Asset < ActiveRecord::Base
	belongs_to :person, class_name: "Person", foreign_key: "asset_id", polymorphic: true, dependent: :destroy
  
  has_attached_file :asset, styles: lambda { |a| a.instance.asset_content_type =~ %r(image) ? { medium: "300x300>", thumb: "120x90>", mini: "64x64>"} : {} }

	def is_image?
	  return false unless asset.content_type
	  ['image/jpeg', 'image/pjpeg', 'image/gif', 'image/png', 'image/x-png', 'image/jpg'].include?(asset.content_type)
	end  

end
