class Supplier < ApplicationRecord
  has_many :product_types
  
  validates :trading_name, :company_name, 
  :cnpj, :email, presence: true
  validates :cnpj, uniqueness: true , length: { is: 14 }
end
