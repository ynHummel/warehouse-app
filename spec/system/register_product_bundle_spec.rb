require 'rails_helper'

describe 'User registers a bundle' do
  it 'successfully' do
    user = User.create!(email: 'yuri@email.com', password: '12345678')
    supplier = Supplier.create!(
      trading_name: 'Vinícola Miolo', company_name: 'Miolo Fábrica de bebidas LTDA',
      cnpj: '51905325000154', address: 'Avenida Cabernet, 100',
      email: 'contato@miolovinhos.com', telephone: '71 1234-5678'
    )
    cat = ProductCategory.create!(name: 'Bebidas e utensílios')
    ProductType.create!(
      name: 'Vinho Tinto Miolo', height: 30, width: 10, length: 10,
      weight: 800, supplier: supplier, product_category: cat
    )
    ProductType.create!(
      name: 'Vinho Rose Miolo', height: 30, width: 10, length: 10,
      weight: 801, supplier: supplier, product_category: cat
    )
    ProductType.create!(
      name: 'Vinho Branco Miolo', height: 30, width: 10, length: 10,
      weight: 802, supplier: supplier, product_category: cat
    )
    ProductType.create!(
      name: 'Taça para vinho', height: 12, width: 10, length: 10,
      weight: 50, supplier: supplier, product_category: cat
    )

    login_as(user, :scope => :user)
    visit root_path
    click_on 'Criar novo kit de produtos'
    fill_in 'Nome', with: 'Kit Degustação Miolo'
    check 'Vinho Tinto Miolo'
    check 'Vinho Branco Miolo'
    click_on 'Salvar'

    expect(page).to have_content 'Kit Degustação Miolo'
    expect(page).to have_content 'Peso do kit:'
    expect(page).to have_content '1602'
    expect(page).to have_content 'Produtos'
    expect(page).to have_content 'Nome'
    expect(page).to have_content 'Peso'
    expect(page).to have_content 'Vinho Tinto Miolo'
    expect(page).to have_content '800'
    expect(page).to have_content 'Vinho Branco Miolo'
    expect(page).to have_content '802'
    expect(page).not_to have_content 'Vinho Rose Miolo'
  end
end
