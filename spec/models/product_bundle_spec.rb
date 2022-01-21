require 'rails_helper'

RSpec.describe ProductBundle, type: :model do
  context 'SKU' do
    it 'should generate a SKU' do
      supplier = Supplier.create!(
        trading_name: 'Vinícola Miolo', company_name: 'Miolo Fábrica de bebidas LTDA',
        cnpj: '51905325000154', address: 'Avenida Cabernet, 100',
        email: 'contato@miolovinhos.com', telephone: '71 1234-5678'
      )
      cat = ProductCategory.create!(name: 'Bebidas e utensílios')
      p1 = ProductType.create!(
        name: 'Vinho Tinto Miolo', height: 30, width: 10, length: 10,
        weight: 800, supplier: supplier, product_category: cat
      )
      p2 = ProductType.create!(
        name: 'Vinho Branco Miolo', height: 30, width: 10, length: 10,
        weight: 802, supplier: supplier, product_category: cat
      )
      pb = ProductBundle.create!(
        name: 'Kit vinhos Miolo', product_types: [p1, p2]
      )

      expect(pb.sku).not_to eq nil
      expect(pb.sku.length).to eq 21
      expect(pb.sku[0]).to eq 'K'
    end
  end
end
