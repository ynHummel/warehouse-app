require 'rails_helper'

describe 'Visitor sees the warehouse page' do
  it "and see it's details" do
    Warehouse.create!( 
      name: 'Guarulhos', code: 'GRU', description: 'descrição teste',
      address: 'Av teste', city: 'São Paulo', state: 'SP',
      postal_code: '00000-000', total_area: 10000, useful_area: 8000 
    )

    visit root_path
    click_on 'Guarulhos'

    expect(page).to have_content 'Guarulhos'
    expect(page).to have_content 'GRU'
    expect(page).to have_content 'descrição teste'
    expect(page).to have_content 'Av teste'
    expect(page).to have_content 'São Paulo/SP'
    expect(page).to have_content 'CEP: 00000-000'
    expect(page).to have_content 'Área total: 10000'
    expect(page).to have_content 'Área Útil: 8000'

  end

  it 'and goes back to the homepage' do
    Warehouse.create!( 
      name: 'Guarulhos', code: 'GRU', description: 'descrição teste',
      address: 'Av teste', city: 'São Paulo', state: 'SP',
      postal_code: '00000-000', total_area: 10000, useful_area: 8000 
    )

    visit root_path
    click_on 'Guarulhos'
    click_on 'Voltar'

    expect(current_path).to eq root_path 
  end
end