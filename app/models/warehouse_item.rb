class WarehouseItem < ApplicationRecord
  belongs_to :warehouse
  belongs_to :product_type

  before_create :generate_code

  private

  def generate_code
    loop do
      new_code = SecureRandom.alphanumeric(17).upcase
      if !WarehouseItem.where(id_code: new_code).exists?
        self.id_code = "#{self.product_type.name[0, 3].upcase}#{new_code}"
        break
      end
    end
  end
end
