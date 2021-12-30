require 'rails_helper'

describe 'User access the Product Categories page' do
  it 'successfully' do
    ProductCategory.create!(name: 'Canecas')
    ProductCategory.create!(name: 'Bebidas')
    ProductCategory.create!(name: 'Utensílios de cozinha')

    visit root_path
    click_on 'Categorias'

    expect(page).to have_css('h1', text: 'Categorias de produtos')
    expect(page).to have_content 'Canecas'
    expect(page).to have_content 'Bebidas'
    expect(page).to have_content 'Utensílios de cozinha'

  end

  it 'and there are no registered categories' do
    
    visit root_path
    click_on 'Categorias'

    expect(page).to have_content 'Nenhuma categoria cadastrada'
  end

  it 'and can access individual categories pages' do

    cat = ProductCategory.create!(name: 'Utensílios de cozinha')
    cat1 = ProductCategory.create!(name: 'Bebidas')

    supplier = Supplier.create!( 
      trading_name: 'Vinícola Miolo', company_name: 'Miolo Fábrica de bebidas LTDA',
      cnpj: '51905325000154', address: 'Avenida Cabernet, 100',
      email: 'contato@miolovinhos.com', telephone: '71 1234-5678' 
    )

    p1 = ProductType.create!( 
      name: 'Vinho Tinto Miolo', height: 30, width: 10, length: 10,
      weight: 800, supplier: supplier, product_category: cat1
    )
    p2 = ProductType.create!( 
      name: 'Vinho Branco Miolo', height: 30, width: 10, length: 10,
      weight: 800, supplier: supplier, product_category: cat1
    )
    p3 = ProductType.create!( 
      name: 'Taça para vinho', height: 12, width: 10, length: 10,
      weight: 50, supplier: supplier, product_category: cat
    )

    visit root_path
    click_on 'Categorias'
    click_on 'Bebidas'

    expect(page).to have_content 'Bebidas'
    expect(page).to have_content 'Vinho Tinto Miolo'
    expect(page).to have_content "#{p1.sku}"
    expect(page).to have_content 'Vinho Branco Miolo'
    expect(page).to have_content "#{p2.sku}"

    expect(page).not_to have_content 'Taça para vinho'
    expect(page).not_to have_content "#{p3.sku}"

  end

  it 'and there are no product_types inside this category' do
    cat = ProductCategory.create!(name: 'Bebidas')

    visit root_path
    click_on 'Categorias'
    click_on 'Bebidas'

    expect(page).to have_content 'Não existem produtos nessa categoria'
    
  end

end