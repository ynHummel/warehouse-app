require 'rails_helper'

describe 'User registers a warehouse' do
  it 'from the homepage' do
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
  end

  it 'successfully' do
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
    click_on 'Salvar'

    expect(page).to have_content('Juiz de Fora')
    expect(page).to have_content('JDF')
    expect(page).to have_content('Um galpão mineiro com pé no Rio')
    expect(page).to have_content('Av Rio Branco')
    expect(page).to have_content('Juiz de Fora/BH')
    expect(page).to have_content('CEP: 36000-000')
    expect(page).to have_content('Área Total: 5000 m2')
    expect(page).to have_content('Área Útil: 3000 m2')
    expect(page).to have_content('Galpão registrado com sucesso')
  end

  it 'and it fails' do
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