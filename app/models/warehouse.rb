class Warehouse < ApplicationRecord
  has_many :warehouse_items
  has_and_belongs_to_many :product_categories

  validates :name, :code, :address,
            :state, :city, :postal_code,
            :description, :total_area, :useful_area, presence: true
  validates :code, uniqueness: true
  validates :postal_code, format: { with: /\d{5}-\d{3}/ }, length: { is: 9 }
end
