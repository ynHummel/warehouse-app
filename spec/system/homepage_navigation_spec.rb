require 'rails_helper'

describe 'Visitor opens the homepage' do

  it 'and sees a welcome message' do

    visit root_path

    expect(page).to have_content('Bem vindo ao WareHouse App')
    
  end

end