class ProductBundle < ApplicationRecord
  has_many :product_bundle_items
  has_many :product_types, through: :product_bundle_items

  before_create :generate_sku, :bundle_weight

  private

  def generate_sku
    loop do
      new_sku = SecureRandom.alphanumeric(20).upcase
      if !ProductType.where(sku: new_sku).exists?
        self.sku = "K#{new_sku}"
        break
      end
    end
  end

  def bundle_weight
    total = 0
    self.product_types.each do |p|
      total += p.weight
    end
    self.weight = total
  end
end
