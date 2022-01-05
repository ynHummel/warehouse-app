class WarehouseItem < ApplicationRecord
  belongs_to :warehouse
  belongs_to :product_type
end
