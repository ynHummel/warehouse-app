require 'rails_helper'

describe 'User register a product type' do
  it 'successfully' do
    Supplier.create!(trading_name: 'Cerâmicas Geek', 
      company_name: 'Geek fornecimentos SA', cnpj: '12345678901234',
      email: 'geekceramicas@fornecimentos.com' 
    )

    Supplier.create!(trading_name: 'Fábrica de Camisetas', 
      company_name: 'Esporte roupas SA', cnpj: '12341234567890',
      email: 'golcamisas@fornecimentos.com' 
    )

    visit root_path
    click_on 'Cadastrar modelo de produto'
    fill_in 'Nome', with: 'Caneca Star Wars'
    fill_in 'Peso', with: 300
    fill_in 'Altura', with: 12
    fill_in 'Largura', with: 8
    fill_in 'Profundidade', with: 14
    fill_in 'Código SKU', with: 'CN202100SW'
    select 'Cerâmicas Geek', from: 'Fornecedor'
    click_on 'Salvar'
    
    expect(page).to have_content 'Modelo de produto registrado com sucesso'
    expect(page).to have_content 'Caneca Star Wars'
    expect(page).to have_content '300 gramas'
    expect(page).to have_content 'Dimensões: 12 x 8 x 14'
    expect(page).to have_content 'SKU: CN202100SW'
    expect(page).to have_content 'Fornecedor: Cerâmicas Geek'

  end
end