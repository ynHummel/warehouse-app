class CreateSuppliers < ActiveRecord::Migration[6.1]
  def change
    create_table :suppliers do |t|
      t.string :trading_name
      t.string :company_name
      t.string :cnpj
      t.string :address
      t.string :email
      t.string :telephone

      t.timestamps
    end
  end
end
