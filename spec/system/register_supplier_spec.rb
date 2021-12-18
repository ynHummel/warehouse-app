require 'rails_helper'

describe 'User tries to register a supplier' do
  it 'from the homepage' do
    visit root_path
    click_on 'Fornecedores'
    click_on 'Cadastrar fornecedor'

    expect(page).to have_css('h1', text:'Novo Fornecedor') 
    expect(page).to have_content 'Nome Fantasia'
    expect(page).to have_field 'Razão Social' 
    expect(page).to have_field 'CNPJ'
    expect(page).to have_field 'Endereço'
    expect(page).to have_field 'E-mail'
    expect(page).to have_field 'Telefone' 
  end
end