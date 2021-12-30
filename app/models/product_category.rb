class ProductCategory < ApplicationRecord
  has_many :product_types
  
  validates :name, presence: true, uniqueness: true
end
