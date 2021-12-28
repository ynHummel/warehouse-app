class ProductBundle < ApplicationRecord
  has_many :product_bundle_items
  has_many :product_types, through: :product_bundle_items

  before_create :generate_sku

  private
  def generate_sku
    loop do
      new_sku = SecureRandom.hex(10).upcase
      if !ProductType.where(sku: new_sku).exists?
        self.sku = "K#{new_sku}"
        break
      end
    end
  end

end
