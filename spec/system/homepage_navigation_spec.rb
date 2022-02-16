require 'rails_helper'

describe 'Visitor opens the homepage' do
  it 'successfully' do
    visit root_path
    expect(page).to have_css('h1', text: 'WareHouse App')
    expect(page).to have_css('small', text: 'Sistema de gestão de galpões')
  end

  it 'and sees all registered warehouses' do
    Warehouse.create!(
      name: 'Guarulhos', code: 'GRU', description: 'teste',
      address: 'Av teste', city: 'São Paulo', state: 'SP',
      postal_code: '00000-000', total_area: 10000, useful_area: 8000
    )
    Warehouse.create!(
      name: 'Porto Alegre', code: 'POA', description: 'teste',
      address: 'Av teste', city: 'Porto Alegre', state: 'RS',
      postal_code: '00001-000', total_area: 10000, useful_area: 8000
    )
    Warehouse.create!(
      name: 'São Luís', code: 'SLZ', description: 'teste',
      address: 'Av teste', city: 'São Luís', state: 'MA',
      postal_code: '00002-000', total_area: 10000, useful_area: 8000
    )
    Warehouse.create!(
      name: 'Vitória', code: 'VIX', description: 'teste',
      address: 'Av teste', city: 'Vitória', state: 'ES',
      postal_code: '00003-000', total_area: 10000, useful_area: 8000
    )

    visit root_path

    expect(page).to have_content('Guarulhos')
    expect(page).to have_content('GRU')
    expect(page).to have_content('Porto Alegre')
    expect(page).to have_content('POA')
    expect(page).to have_content('São Luís')
    expect(page).to have_content('SLZ')
    expect(page).to have_content('Vitória')
    expect(page).to have_content('VIX')
  end

  it "and can't see all warehouse details" do
    Warehouse.create!(
      name: 'Guarulhos', code: 'GRU', description: 'desc teste',
      address: 'Av teste', city: 'São Paulo', state: 'SP',
      postal_code: '00000-000', total_area: 10000, useful_area: 8000
    )

    visit root_path

    expect(page).not_to have_content('desc teste')
    expect(page).not_to have_content('Av teste')
    expect(page).not_to have_content('São Paulo')
    expect(page).not_to have_content('SP')
    expect(page).not_to have_content('00000-000')
    expect(page).not_to have_content('10000')
    expect(page).not_to have_content('8000')
  end

  context 'and search for warehouse' do
    it 'name and city' do
      user = User.create!(email: 'admin@teste.com', password: 12345678)
      Warehouse.create!(
        name: 'Guarulhos', code: 'GRU', description: 'teste',
        address: 'Av teste', city: 'São Paulo', state: 'SP',
        postal_code: '00000-000', total_area: 10000, useful_area: 8000
      )
      Warehouse.create!(
        name: 'São Luís', code: 'SLZ', description: 'teste',
        address: 'Av teste', city: 'Teste', state: 'MA',
        postal_code: '00002-000', total_area: 10000, useful_area: 8000
      )
      Warehouse.create!(
        name: 'Porto Alegre', code: 'POA', description: 'teste',
        address: 'Av teste', city: 'Porto Alegre', state: 'RS',
        postal_code: '00001-000', total_area: 10000, useful_area: 8000
      )

      login_as(user, :scope => :user)
      visit root_path
      fill_in 'Busca:', with: 'São'
      click_on 'Pesquisar'

      expect(current_path).to eq search_warehouses_path
      expect(page).to have_content('Guarulhos')
      expect(page).to have_content('GRU')
      expect(page).to have_content('São Paulo')
      expect(page).to have_content('São Luís')
      expect(page).to have_content('SLZ')
      expect(page).to have_content('Teste')
      expect(page).not_to have_content('Porto Alegre')
      expect(page).not_to have_content('POA')
    end

    it 'code' do
      user = User.create!(email: 'admin@teste.com', password: 12345678)
      Warehouse.create!(
        name: 'Guarulhos', code: 'GRU', description: 'teste',
        address: 'Av teste', city: 'São Paulo', state: 'SP',
        postal_code: '00000-000', total_area: 10000, useful_area: 8000
      )
      Warehouse.create!(
        name: 'Porto Alegre', code: 'POA', description: 'teste',
        address: 'Av teste', city: 'Porto Alegre', state: 'RS',
        postal_code: '00001-000', total_area: 10000, useful_area: 8000
      )

      login_as(user, :scope => :user)
      visit root_path
      fill_in 'Busca:', with: 'RU'
      click_on 'Pesquisar'

      expect(current_path).to eq search_warehouses_path
      expect(page).to have_content('Guarulhos')
      expect(page).to have_content('GRU')
      expect(page).to have_content('São Paulo')
      expect(page).not_to have_content('Porto Alegre')
      expect(page).not_to have_content('POA')
    end
  end
end
