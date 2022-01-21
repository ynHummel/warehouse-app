require 'rails_helper'

RSpec.describe WarehouseItem, type: :model do
  it 'should generate an id code' do
    cat = ProductCategory.create!(name: 'Monitores')
    supp1 = Supplier.create!(
      trading_name: 'Fantasy Supplier', company_name: 'FS fornecimentos SA',
      cnpj: '12345678901234', address: 'Av dos Produtos',
      email: 'fantasyprodutos@fornecimentos.com', telephone: '00000000'
    )
    p1 = ProductType.create!(
      name: 'Monitor Gamer', weight: 2000, supplier: supp1,
      height: 14, width: 10, length: 12, product_category: cat
    )
    w1 = Warehouse.create!(
      name: 'Guarulhos', code: 'GRU', description: 'teste',
      address: 'Av teste', city: 'São Paulo', state: 'SP',
      postal_code: '00000-000', total_area: 10000, useful_area: 8000
    )
    wi = WarehouseItem.create!(warehouse: w1, product_type: p1)

    expect(wi.id_code).not_to eq nil
    expect(wi.id_code.length).to eq 20
    expect(wi.id_code[0, 3]).to eq 'MON'
  end
end
