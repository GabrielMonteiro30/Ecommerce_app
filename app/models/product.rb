class Product < ApplicationRecord
  has_many :sales
  
  scope :active, -> { where(deleted_at: nil) }
  scope :inactive, -> { where('deleted_at IS NOT NULL') }
  
  has_attached_file :upload, :styles => { :medium => "300x300>", :thumb => "200x200>" } 
  validates_attachment_content_type :upload, :content_type => /\Aimage\/.*\Z/
  
  validates :name, :presence => { :message => "é obrigatório!"}
  validates :price, :presence => {:message => "é obrigatório!"}
end
