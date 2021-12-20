class ProductType < ApplicationRecord
  belongs_to :supplier

  def dimensions
    return "#{height} x #{width} x #{length}"
  end
end
