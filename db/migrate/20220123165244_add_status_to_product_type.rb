class AddStatusToProductType < ActiveRecord::Migration[6.1]
  def change
    add_column :product_types, :status, :integer, default: 0
  end
end
