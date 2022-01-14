class ProductCategory < ApplicationRecord
  has_many :product_types
  has_and_belongs_to_many :warehouses

  validates :name, presence: true, uniqueness: true
end
