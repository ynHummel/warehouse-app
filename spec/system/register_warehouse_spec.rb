require 'rails_helper'

describe 'User tries to register a warehouse' do
  it 'Visitor cant see the menu' do
    visit root_path

    expect(page).not_to have_link 'Cadastrar novo galpão'
  end

  it 'Visitor cant access the registration form' do
    visit new_warehouse_path

    expect(current_path).to eq new_user_session_path
  end

  it 'from the homepage' do
    user = User.create!(email: 'yuri@email.com', password:'12345678')
    
    login_as(user, :scope => :user)
    visit root_path
    click_on 'Cadastrar novo galpão'

    expect(page).to have_content 'Novo Galpão'
    expect(page).to have_field 'Nome' 
    expect(page).to have_field 'Código'
    expect(page).to have_field 'Endereço'
    expect(page).to have_field 'Cidade'
    expect(page).to have_field 'Estado' 
    expect(page).to have_field 'CEP'
    expect(page).to have_field 'Descrição'
    expect(page).to have_field 'Área Total'
    expect(page).to have_field 'Área Útil'
    expect(page).to have_content 'Categorias'
  end

  it 'successfully' do
    user = User.create!(email: 'yuri@email.com', password:'12345678')
    ProductCategory.create!(name: 'Canecas')
    ProductCategory.create!(name: 'Móveis')
    ProductCategory.create!(name: 'Alimentos')
    
    login_as(user, :scope => :user)
    visit root_path
    click_on 'Cadastrar novo galpão'
    fill_in 'Nome', with: 'Juiz de Fora'
    fill_in 'Código', with: 'JDF'
    fill_in 'Endereço', with: 'Av Rio Branco'
    fill_in 'Cidade', with: 'Juiz de Fora'
    fill_in 'Estado', with: 'BH'
    fill_in 'CEP', with: '36000-000'
    fill_in 'Descrição', with: 'Um galpão mineiro com pé no Rio'
    fill_in 'Área Total', with: '5000'
    fill_in 'Área Útil', with: '3000'
    within("div#categories") do
      check 'Móveis'
      check 'Canecas'
    end
    click_on 'Salvar'

    expect(page).to have_content('Juiz de Fora')
    expect(page).to have_content('JDF')
    expect(page).to have_content('Um galpão mineiro com pé no Rio')
    expect(page).to have_content('Av Rio Branco')
    expect(page).to have_content('Juiz de Fora/BH')
    expect(page).to have_content('CEP: 36000-000')
    expect(page).to have_content('Área Total: 5000 m2')
    expect(page).to have_content('Área Útil: 3000 m2')
    within('div#warehouse-categories') do
      expect(page).to have_content('Categorias Permitidas')
      expect(page).to have_content('Móveis')
      expect(page).to have_content('Canecas')
      expect(page).not_to have_content('Alimentos')

    end

    expect(page).to have_content('Galpão registrado com sucesso')
  end

  it 'and it fails' do
    user = User.create!(email: 'yuri@email.com', password:'12345678')
    ProductCategory.create!(name: 'Canecas')
    
    login_as(user, :scope => :user)
    visit root_path
    click_on 'Cadastrar novo galpão'
    click_on 'Salvar'

    expect(page).to_not have_content('Galpão registrado com sucesso')
    expect(page).to have_content('Não foi possível salvar o galpão')
    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('Código não pode ficar em branco')
    expect(page).to have_content('Endereço não pode ficar em branco')
    expect(page).to have_content('Cidade não pode ficar em branco')
    expect(page).to have_content('Estado não pode ficar em branco')
    expect(page).to have_content('CEP não pode ficar em branco')
    expect(page).to have_content('Descrição não pode ficar em branco')
    expect(page).to have_content('Área Total não pode ficar em branco')
    expect(page).to have_content('Área Útil não pode ficar em branco')
  end
end