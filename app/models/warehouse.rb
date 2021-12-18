class Warehouse < ApplicationRecord
  validates :name, :code, :address, 
            :state, :city, :postal_code, 
            :description, :total_area, :useful_area, presence: true
  validates :code, uniqueness: true
  validates :postal_code, format: { with: /\d{5}-\d{3}/ }
end
