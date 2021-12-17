class CreateWarehouses < ActiveRecord::Migration[6.1]
  def change
    create_table :warehouses do |t|
      t.string :name
      t.string :code
      t.string :description
      t.string :address
      t.string :city
      t.string :state
      t.string :postal_code
      t.integer :total_area
      t.integer :useful_area

      t.timestamps
    end
  end
end
