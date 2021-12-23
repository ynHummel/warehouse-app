class ProductBundleItem < ApplicationRecord
  belongs_to :product_type
  belongs_to :product_bundle
end
