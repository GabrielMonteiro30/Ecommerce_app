class Sale < ApplicationRecord
  belongs_to :client
  has_many :sale_items
  has_many :products, through: :sale_items
  
  accepts_nested_attributes_for :sale_items, allow_destroy: true, reject_if: :all_blank

  validates :client, :presence => { :message => " é obrigatório !"}
end
