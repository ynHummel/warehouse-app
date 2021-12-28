require 'rails_helper'

describe 'User registers a bundle' do
  it 'successfully' do
    supplier = Supplier.create!( 
      trading_name: 'Vinícola Miolo', company_name: 'Miolo Fábrica de bebidas LTDA',
      cnpj: '51905325000154', address: 'Avenida Cabernet, 100',
      email: 'contato@miolovinhos.com', telephone: '71 1234-5678' 
    )
    ProductType.create!( 
      name: 'Vinho Tinto Miolo', height: 30, width: 10, length: 10,
      weight: 800, supplier: supplier
    )
    ProductType.create!( 
      name: 'Vinho Rose Miolo', height: 30, width: 10, length: 10,
      weight: 800, supplier: supplier
    )
    ProductType.create!( 
      name: 'Vinho Branco Miolo', height: 30, width: 10, length: 10,
      weight: 800, supplier: supplier
    )
    ProductType.create!( 
      name: 'Taça para vinho', height: 12, width: 10, length: 10,
      weight: 50, supplier: supplier
    )

    visit root_path
    click_on 'Criar novo kit de produtos'
    fill_in 'Nome', with: 'Kit Degustação Miolo'
    check 'Vinho Tinto Miolo'
    check 'Vinho Branco Miolo'
    click_on 'Salvar'

    expect(page).to have_content 'Kit Degustação Miolo'
    expect(page).to have_content 'Vinho Tinto Miolo'
    expect(page).to have_content 'Vinho Branco Miolo'
    expect(page).not_to have_content 'Vinho Rose Miolo'
  end

end