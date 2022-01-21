require 'rails_helper'

describe 'User register items entry' do
  it 'successfully' do
    user = create(:user)
    cat = ProductCategory.create!(name: 'Brinquedos')
    cat1 = ProductCategory.create!(name: 'Canecas')
    w1 = create(:warehouse, product_categories: [cat1])
    supplier = create(:supplier)
    p1 = create(:product_type, name: 'Caneca Star Wars', product_category: cat1)
    p2 = create(:product_type, product_category: cat)
    p3 = create(:product_type, product_category: cat1)

    login_as(user)
    visit root_path
    click_on 'Guarulhos'
    fill_in 'Quantidade', with: 10
    select 'Caneca Star Wars', from: 'Produto'
    #preço
    #lote
    click_on 'Confirmar'

    expect(current_path).to eq warehouse_path(w1.id)
    expect(page).to have_css('h2', text: 'Estoque')
    within("div#product-#{p1.id}") do
      expect(page).to have_content('Caneca Star Wars')
      expect(page).to have_content('10 unidades')
    end
  end

  it 'and sees the warehouses in the product type page' do
    user = User.create(email: 'admin@email.com', password: '12345678')
    cat = ProductCategory.create!(name: 'Bebidas')
    supplier = Supplier.create!( 
      trading_name: 'Vinícola Miolo', company_name: 'Miolo Fábrica de bebidas LTDA',
      cnpj: '51905325000154', address: 'Avenida Cabernet, 100',
      email: 'contato@miolovinhos.com', telephone: '71 1234-5678' 
    )
    w1 = Warehouse.create!( 
      name: 'Guarulhos', code: 'GRU', description: 'teste',
      address: 'Av teste', city: 'São Paulo', state: 'SP',
      postal_code: '00000-000', total_area: 10000, useful_area: 8000 
    )
    w2 = Warehouse.create!( 
      name: 'Porto Alegre', code: 'POA', description: 'teste',
      address: 'Av teste', city: 'Porto Alegre', state: 'RS',
      postal_code: '00001-000', total_area: 10000, useful_area: 8000 
    )
    w3 = Warehouse.create!( 
      name: 'São Luís', code: 'SLZ', description: 'teste',
      address: 'Av teste', city: 'São Luís', state: 'MA',
      postal_code: '00002-000', total_area: 10000, useful_area: 8000 
    )
    p = ProductType.create!( 
      name: 'Vinho Tinto Miolo', height: 30, width: 10, length: 10,
      weight: 800, supplier: supplier, product_category: cat
    )
    3.times do
      WarehouseItem.create!(warehouse: w1, product_type: p)
    end
    2.times do
      WarehouseItem.create!(warehouse: w2, product_type: p)
    end

    login_as(user)
    visit root_path
    click_on 'Fornecedores'
    click_on 'Vinícola Miolo'
    click_on 'Vinho Tinto Miolo'

    expect(page).to have_css('h2', text:'Disponível nos galpões:')
    expect(page).to have_content('Guarulhos') 
    expect(page).to have_content('GRU')
    expect(page).to have_content('3 unidades')
    expect(page).to have_content('Porto Alegre')
    expect(page).to have_content('POA')
    expect(page).to have_content('2 unidades')
    expect(page).not_to have_content('São Luís')
    expect(page).not_to have_content('SLZ')
  end

  it 'and can only select products with permited categories' do

    user = User.create(email: 'admin@email.com', password: '12345678')
    cat = ProductCategory.create!(name: 'Brinquedos')
    cat1 = ProductCategory.create!(name: 'Canecas')
    w1 = Warehouse.create!( 
      name: 'Guarulhos', code: 'GRU', description: 'teste',
      address: 'Av teste', city: 'São Paulo', state: 'SP',
      postal_code: '00000-000', total_area: 10000, useful_area: 8000,
      product_categories: [cat1]
    )
    supplier = Supplier.create!( 
      trading_name: 'Fantasy Supplier', company_name: 'FS fornecimentos SA',
      cnpj: '12345678901234', address: 'Av dos Produtos',
      email: 'fantasyprodutos@fornecimentos.com', telephone: '00000000' 
    )
    p1 = ProductType.create!( 
      name: 'Caneca Star Wars', height: 14, width: 10, length: 8,
      weight: 300, supplier: supplier, product_category: cat1
    )
    p2 = ProductType.create!( 
      name: 'Caneca Liga da Justiça', height: 14, width: 10, length: 8,
      weight: 300, supplier: supplier, product_category: cat1
    )
    p3 = ProductType.create!( 
      name: 'Pelúcia Dumbo', height: 50, width: 40, length: 20,
      weight: 400, supplier: supplier, product_category: cat
    )
    
    login_as(user)
    visit root_path
    click_on 'Guarulhos'
    

    expect(current_path).to eq warehouse_path(w1.id)
    expect(page).to have_content('Caneca Liga da Justiça')
    expect(page).to have_content('Caneca Star Wars')
    expect(page).not_to have_content('Pelúcia Dumbo')
    
  end
  
end