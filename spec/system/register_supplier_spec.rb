require 'rails_helper'

describe 'User tries to register a supplier' do

  it 'from the homepage' do
    user = User.create!(email: 'yuri@email.com', password:'12345678')
    login_as(user, :scope => :user)

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

  it 'successfully' do
    user = User.create!(email: 'yuri@email.com', password:'12345678')
    login_as(user, :scope => :user)

    visit root_path
    click_on 'Fornecedores'
    click_on 'Cadastrar fornecedor'
    fill_in 'Nome Fantasia', with: 'Fantasy Supplier'
    fill_in 'Razão Social', with: 'FS fornecimentos SA'
    fill_in 'CNPJ', with: '12345678901234'
    fill_in 'Endereço', with: 'Av dos Produtos'
    fill_in 'E-mail', with: 'fantasyprodutos@fornecimentos.com'
    fill_in 'Telefone', with: '00000000'
    click_on 'Salvar'

    expect(page).to have_content('Fornecedor registrado com sucesso')
    expect(page).to have_content('Fantasy Supplier')
    expect(page).to have_content('FS fornecimentos SA')
    expect(page).to have_content('CNPJ: 12345678901234')
    expect(page).to have_content('Endereço: Av dos Produtos')
    expect(page).to have_content('E-mail: fantasyprodutos@fornecimentos.com')
    expect(page).to have_content('Telefone: 00000000')
  end

  it 'with obligatory information at fault' do
    user = User.create!(email: 'yuri@email.com', password:'12345678')
    login_as(user, :scope => :user)

    visit root_path
    click_on 'Fornecedores'
    click_on 'Cadastrar fornecedor'
    click_on 'Salvar'

    expect(page).to_not have_content('Fornecedor registrado com sucesso')
    expect(page).to have_content('Não foi possível registrar o Fornecedor')
    expect(page).to have_content('Nome Fantasia não pode ficar em branco')
    expect(page).to have_content('Razão Social não pode ficar em branco')
    expect(page).to have_content('CNPJ não pode ficar em branco')
    expect(page).to have_content('E-mail não pode ficar em branco')
  end

end