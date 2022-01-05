require 'rails_helper'

describe 'User register items entry' do
  it 'successfully' do
    user = User.create(email: 'admin@email.com', password: '12345678')
    w1 = Warehouse.create!( 
      name: 'Guarulhos', code: 'GRU', description: 'teste',
      address: 'Av teste', city: 'São Paulo', state: 'SP',
      postal_code: '00000-000', total_area: 10000, useful_area: 8000 
    )
    supplier = Supplier.create!( 
      trading_name: 'Fantasy Supplier', company_name: 'FS fornecimentos SA',
      cnpj: '12345678901234', address: 'Av dos Produtos',
      email: 'fantasyprodutos@fornecimentos.com', telephone: '00000000' 
    )
    cat = ProductCategory.create!(name: 'Categoria')
    p1 = ProductType.create!( 
      name: 'Pelúcia Dumbo', height: 50, width: 40, length: 20,
      weight: 400, supplier: supplier, product_category: cat
    )
    p2 = ProductType.create!( 
      name: 'Caneca Star Wars', height: 14, width: 10, length: 8,
      weight: 300, supplier: supplier, product_category: cat
    )

    login_as(user)
    visit root_path
    click_on 'Guarulhos'
    fill_in 'Quantidade', with: 100
    select 'Pelúcia Dumbo', from: 'Produto'
    #preço
    #lote
    click_on 'Confirmar'

    expect(current_path).to eq warehouse_path(w1.id)
    expect(page).to have_css('h2', text: 'Estoque')
    within("div#product-#{p1.id}") do
      expect(page).to have_content('Pelúcia Dumbo')
      expect(page).to have_content('100 unidades')
    end
  end
end