class AddProductCategoryToProductType < ActiveRecord::Migration[6.1]
  def change
    add_reference :product_types, :product_category, null: false, foreign_key: true, default: 0
  end
end
