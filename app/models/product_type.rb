class ProductType < ApplicationRecord
  belongs_to :supplier

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
      new_sku = SecureRandom.hex(10).upcase
      if !ProductType.where(sku: new_sku).exists?
        self.sku = new_sku
        break
      end
    end
  end
  
end
