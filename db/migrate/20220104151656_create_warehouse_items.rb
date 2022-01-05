class CreateWarehouseItems < ActiveRecord::Migration[6.1]
  def change
    create_table :warehouse_items do |t|
      t.references :warehouse, null: false, foreign_key: true
      t.references :product_type, null: false, foreign_key: true
      t.string :id_code

      t.timestamps
    end
  end
end
