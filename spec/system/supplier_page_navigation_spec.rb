require 'rails_helper'

describe 'Visitor opens the homepage' do
  it 'successfully' do
    visit root_path
    click_on 'Fornecedores' 

    expect(page).to have_css('h1', text: 'Fornecedores Cadastrados')
  end

end