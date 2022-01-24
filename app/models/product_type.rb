class ProductType < ApplicationRecord
  enum status: { sellable: 0, unsellable: 1 }

  belongs_to :supplier
  belongs_to :product_category
  has_many :product_bundle_items
  has_many :product_bundles, through: :product_bundle_items
  has_many :warehouse_items

  before_create :generate_sku

  validates :name, :weight, :height, :width,
            :length, presence: :true
  validates :sku, uniqueness: true
  validates :weight, :height, :width, :length, numericality: { greater_than: 0 }

  def dimensions
    return "#{height} x #{width} x #{length}"
  end

  private

  def generate_sku
    loop do
      new_sku = SecureRandom.alphanumeric(20).upcase
      if !ProductType.where(sku: new_sku).exists?
        self.sku = new_sku
        break
      end
    end
  end
end
