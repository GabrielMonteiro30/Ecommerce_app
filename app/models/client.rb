class Client < ApplicationRecord
  # default_scope { where(deleted_at: nil) }
  scope :active, -> { where(deleted_at: nil) }
  scope :inactive, -> { where('deleted_at IS NOT NULL') }
  
  validates :name, presence: { message: "é obrigatório!"}
  validates :email, presence: { message: "é obrigatório!"}
end