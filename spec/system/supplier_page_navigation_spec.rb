require 'rails_helper'

describe 'Visitor opens the supplier page' do
  it 'successfully' do
    visit root_path
    click_on 'Fornecedores' 

    expect(page).to have_css('h1', text: 'Fornecedores Cadastrados')
  end

  it 'and can see all the registered suppliers' do
    Supplier.create!( 
      trading_name: 'Fantasy Supplier', company_name: 'FS fornecimentos SA',
      cnpj: '12345678901234', address: 'Av dos Produtos',
      email: 'fantasyprodutos@fornecimentos.com', telephone: '00000000' 
    )
    Supplier.create!( 
      trading_name: 'Real Supplier', company_name: 'RS fornecimentos SA',
      cnpj: '12341234567890', address: 'Av dos Serviços',
      email: 'realprodutos@fornecimentos.com', telephone: '00000001'
    )
    
    visit root_path
    click_on 'Fornecedores'
    
    expect(page).to have_content('Fantasy Supplier')
    expect(page).to have_content('FS fornecimentos SA')
    expect(page).to have_content('Real Supplier')
    expect(page).to have_content('RS fornecimentos SA')
    
  end

  it 'and there are no suppliers' do
    visit root_path
    click_on 'Fornecedores'

    expect(page).to have_content 'Nenhum fornecedor cadastrado'
  end
end