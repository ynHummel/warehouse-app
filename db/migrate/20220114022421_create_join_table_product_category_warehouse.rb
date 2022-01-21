class CreateJoinTableProductCategoryWarehouse < ActiveRecord::Migration[6.1]
  def change
    create_join_table :product_categories, :warehouses do |t|
      t.index :product_category_id
      t.index :warehouse_id
    end
  end
end
