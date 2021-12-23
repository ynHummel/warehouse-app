class ProductBundle < ApplicationRecord
  has_many :product_bundle_items
  has_many :product_types, through: :product_bundle_items
end
