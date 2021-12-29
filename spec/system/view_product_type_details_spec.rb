require 'rails_helper'
describe 'User sees the product type details' do
  it 'successfully' do
    supplier = Supplier.create!( 
      trading_name: 'Fantasy Supplier', company_name: 'FS fornecimentos SA',
      cnpj: '12345678901234', address: 'Av dos Produtos',
      email: 'fantasyprodutos@fornecimentos.com', telephone: '00000000' 
    )
    p1 = ProductType.create!( 
      name: 'Caneca Star Wars', height: 14, width: 10, length: 8,
      weight: 300, supplier: supplier
    )
    p2 = ProductType.create!( 
      name: 'Pelúcia Dumbo', height: 50, width: 40, length: 20,
      weight: 400, supplier: supplier
    )

    visit root_path
    click_on 'Fornecedores'
    click_on 'Fantasy Supplier'
    click_on 'Caneca Star Wars'

    expect(page).to have_css('h1', text: 'Caneca Star Wars')
    expect(page).to have_css('h3', text: "#{p1.sku}")
    expect(page).to have_content '300 gramas'
    expect(page).to have_content 'Dimensões: 14 x 10 x 8'
    expect(page).to have_content 'Fornecedor: Fantasy Supplier'
  end
end