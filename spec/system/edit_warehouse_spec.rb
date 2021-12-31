require 'rails_helper'

describe 'User tries to edit Warehouse details' do
  it 'and sees the update form' do
    user = User.create!(email: 'yuri@email.com', password:'12345678')
    login_as(user, :scope => :user)

    Warehouse.create!( 
      name: 'Guarulhos', code: 'GRU', description: 'teste',
      address: 'Av teste', city: 'São Paulo', state: 'SP',
      postal_code: '00000-000', total_area: 10000, useful_area: 8000 
    )

    visit root_path
    click_on 'Guarulhos'
    click_on 'Editar'

    expect(page).to have_content 'Editar Galpão'
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
    user = User.create!(email: 'yuri@email.com', password:'12345678')
    login_as(user, :scope => :user)
    
    Warehouse.create!( 
      name: 'Guarulhos', code: 'GRU', description: 'teste',
      address: 'Av teste', city: 'São Paulo', state: 'SP',
      postal_code: '00000-000', total_area: 10000, useful_area: 8000 
    )

    visit root_path
    click_on 'Guarulhos'
    click_on 'Editar'

    fill_in 'Nome', with: 'Guarulhoss'
    fill_in 'Código', with: 'URG'
    fill_in 'Endereço', with: 'Av Rio teste'
    fill_in 'Cidade', with: 'São Paulo'
    fill_in 'Estado', with: 'SP'
    fill_in 'CEP', with: '00000-001'
    fill_in 'Descrição', with: 'Teste'
    fill_in 'Área Total', with: '5000'
    fill_in 'Área Útil', with: '3000'
    click_on 'Salvar'

    expect(page).to have_content('Guarulhoss')
    expect(page).to have_content('URG')
    expect(page).to have_content('Teste')
    expect(page).to have_content('Av Rio teste')
    expect(page).to have_content('São Paulo/SP')
    expect(page).to have_content('CEP: 00000-001')
    expect(page).to have_content('Área Total: 5000 m2')
    expect(page).to have_content('Área Útil: 3000 m2')
    expect(page).to have_content('Galpão atualizado com sucesso')
  end

end