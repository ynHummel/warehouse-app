require 'rails_helper'

describe 'Visitor opens the homepage' do

  it 'successfully' do
    visit root_path
    expect(page).to have_css('h1', text: 'WareHouse App')
    expect(page).to have_css('h3', text: 'Boas vindas ao sistema de gestão de estoques')
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

end