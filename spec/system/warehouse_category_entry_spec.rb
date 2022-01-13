require 'rails_helper'

describe 'User opens the warehouse page' do
  it 'and permits a category for products entry' do
    w1 = Warehouse.create!( 
      name: 'Guarulhos', code: 'GRU', description: 'teste',
      address: 'Av teste', city: 'São Paulo', state: 'SP',
      postal_code: '00000-000', total_area: 10000, useful_area: 8000 
    )
    cat = ProductCategory.create!(name: 'Testegoria')
    supplier = Supplier.create!( 
      trading_name: 'Fantasy Supplier', company_name: 'FS fornecimentos SA',
      cnpj: '12345678901234', address: 'Av dos Produtos',
      email: 'fantasyprodutos@fornecimentos.com', telephone: '00000000' 
    )
    p1 = ProductType.create!( 
      name: 'Caneca Star Wars', height: 14, width: 10, length: 8,
      weight: 300, supplier: supplier, product_category: cat
    )

    visit root_path
    click_on 'Guarulhos'
    within("div#categories") do
      select 'Testegoria', from: 'Categorias'
      click_on 'Permitir'
    end

    expect(current_path).to eq w1
    within("div#categories") do
      expect(page).to have_content 'Permitir Categoria'
      expect(page).to have_content 'Categorias Permitidas'
      expect(page).to have_content 'Testegoria'
    end

    



  end
end