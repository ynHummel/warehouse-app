require 'rails_helper'

describe 'User sees supplier details' do
  it 'successfully' do
    Supplier.create!( 
      trading_name: 'Fantasy Supplier', company_name: 'FS fornecimentos SA',
      cnpj: '12345678901234', address: 'Av dos Produtos',
      email: 'fantasyprodutos@fornecimentos.com', telephone: '00000000' 
    )

    visit root_path
    click_on 'Fornecedores'
    click_on 'Fantasy Supplier'

    expect(page).to have_content('Fantasy Supplier')
    expect(page).to have_content('FS fornecimentos SA')
    expect(page).to have_content('CNPJ: 12345678901234')
    expect(page).to have_content('Endereço: Av dos Produtos')
    expect(page).to have_content('E-mail: fantasyprodutos@fornecimentos.com')
    expect(page).to have_content('Telefone: 00000000')
  end

  it 'and see the supplier product types' do
    supplier = Supplier.create!( 
      trading_name: 'Fantasy Supplier', company_name: 'FS fornecimentos SA',
      cnpj: '12345678901234', address: 'Av dos Produtos',
      email: 'fantasyprodutos@fornecimentos.com', telephone: '00000000' 
    )
    ProductType.create!( 
      name: 'Caneca Star Wars', height: 14, width: 10, length: 8,
      weight: 300, sku: 'CN202100SW', supplier: supplier
    )
    ProductType.create!( 
      name: 'Pelúcia Dumbo', height: 50, width: 40, length: 20,
      weight: 400, sku: 'PL202100DMB', supplier: supplier
    )

    visit root_path
    click_on 'Fornecedores'
    click_on 'Fantasy Supplier'

    expect(page).to have_css('h1', text: 'Fantasy Supplier')
    expect(page).to have_css('h2', text: 'Produtos deste Fornecedor:')
    expect(page).to have_content('Caneca Star Wars')
    expect(page).to have_content('CN202100SW')
    expect(page).to have_content('Pelúcia Dumbo')
    expect(page).to have_content('PL202100DMB')
  end
end