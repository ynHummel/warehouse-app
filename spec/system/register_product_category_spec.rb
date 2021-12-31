require 'rails_helper'

describe 'User register a product category' do

  it 'successfully' do
    user = User.create!(email: 'yuri@email.com', password:'12345678')
    login_as(user, :scope => :user)

    visit root_path
    click_on 'Categorias'
    click_on 'Cadastrar categoria de produtos'

    fill_in 'Nome', with: 'Notebooks'
    click_on 'Salvar'

    expect(page).to have_content 'Categoria cadastrada com sucesso'
    expect(current_path).to eq root_path
  end

  it "and don't provide a name" do
    user = User.create!(email: 'yuri@email.com', password:'12345678')
    login_as(user, :scope => :user)

    visit root_path
    click_on 'Categorias'
    click_on 'Cadastrar categoria de produtos'
    click_on 'Salvar'

    expect(page).to have_content 'Falha ao cadastrar Categoria'
    
  end

  it "and tries to register with a duplicated name" do
    user = User.create!(email: 'yuri@email.com', password:'12345678')
    login_as(user, :scope => :user)
    ProductCategory.create!(name: 'Notebooks')

    visit root_path
    click_on 'Categorias'
    click_on 'Cadastrar categoria de produtos'
    fill_in 'Nome', with: 'Notebooks'
    click_on 'Salvar'

    expect(page).to have_content 'Falha ao cadastrar Categoria'
    
  end

end