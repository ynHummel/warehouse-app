require 'rails_helper'

describe 'User tries to edit ProductType details' do
  it 'and sees the update form' do
    user = User.create!(email: 'yuri@email.com', password:'12345678')
    supplier = Supplier.create!( 
      trading_name: 'Vinícola Miolo', company_name: 'Miolo Fábrica de bebidas LTDA',
      cnpj: '51905325000154', address: 'Avenida Cabernet, 100',
      email: 'contato@miolovinhos.com', telephone: '71 1234-5678' 
    )
    Supplier.create!(trading_name: 'Cerâmicas Geek', 
      company_name: 'Geek fornecimentos SA', cnpj: '12345678901234',
      email: 'geekceramicas@fornecimentos.com' 
    )
    cat = ProductCategory.create!(name: 'Bebidas')
    
    ProductType.create!( 
      name: 'Vinho Tinto Miolo', height: 30, width: 10, length: 10,
      weight: 800, supplier: supplier, product_category: cat
    )
    
    login_as(user, :scope => :user)
    visit root_path
    click_on 'Fornecedores'
    click_on 'Vinícola Miolo'
    click_on 'Vinho Tinto Miolo'
    click_on 'Editar'

    expect(page).to have_content 'Editar Modelo de Produto'
    expect(page).to have_field 'Nome' 
    expect(page).to have_field 'Peso'
    expect(page).to have_field 'Altura'
    expect(page).to have_field 'Largura'
    expect(page).to have_field 'Profundidade' 
    expect(page).to have_field 'Fornecedor' 
    expect(page).to have_field 'Categoria' 
    expect(page).to have_button 'Salvar'
  end

  it 'successfully' do
    user = User.create!(email: 'yuri@email.com', password:'12345678')
    supplier = Supplier.create!( 
      trading_name: 'Vinícola Miolo', company_name: 'Miolo Fábrica de bebidas LTDA',
      cnpj: '51905325000154', address: 'Avenida Cabernet, 100',
      email: 'contato@miolovinhos.com', telephone: '71 1234-5678' 
    )
    Supplier.create!(trading_name: 'Cerâmicas Geek', 
      company_name: 'Geek fornecimentos SA', cnpj: '12345678901234',
      email: 'geekceramicas@fornecimentos.com' 
    )
    cat = ProductCategory.create!(name: 'Bebidas')
    
    cat = ProductCategory.create!(name: 'Utensílios de cozinha')
    
    ProductType.create!( 
      name: 'Vinho Tinto Miolo', height: 30, width: 10, length: 10,
      weight: 800, supplier: supplier, product_category: cat
    )
    
    login_as(user, :scope => :user)
    visit root_path
    click_on 'Fornecedores'
    click_on 'Vinícola Miolo'
    click_on 'Vinho Tinto Miolo'
    click_on 'Editar'

    fill_in 'Nome', with: 'Vinho Branco Miolo'
    fill_in 'Peso', with: '801'
    fill_in 'Altura', with: '31'
    fill_in 'Largura', with: '11'
    fill_in 'Profundidade', with: '12'
    select 'Cerâmicas Geek', from: 'Fornecedor'
    select 'Utensílios de cozinha', from: 'Categoria'
    click_on 'Salvar'

    expect(page).to have_content('Modelo de produto atualizado com sucesso')
    expect(page).to have_content('Vinho Branco Miolo')
    expect(page).to have_content('801 gramas')
    expect(page).to have_content('Dimensões: 31 x 11 x 12')
    expect(page).to have_content('Fornecedor: Cerâmicas Geek')
    expect(page).to have_content('Categoria: Utensílios de cozinha')
    
  end

  it 'and it fails' do
    user = User.create!(email: 'yuri@email.com', password:'12345678')
    supplier = Supplier.create!( 
      trading_name: 'Vinícola Miolo', company_name: 'Miolo Fábrica de bebidas LTDA',
      cnpj: '51905325000154', address: 'Avenida Cabernet, 100',
      email: 'contato@miolovinhos.com', telephone: '71 1234-5678' 
    )
    Supplier.create!(trading_name: 'Cerâmicas Geek', 
      company_name: 'Geek fornecimentos SA', cnpj: '12345678901234',
      email: 'geekceramicas@fornecimentos.com' 
    )
    
    cat = ProductCategory.create!(name: 'Bebidas')
    
    ProductType.create!( 
      name: 'Vinho Tinto Miolo', height: 30, width: 10, length: 10,
      weight: 800, supplier: supplier, product_category: cat
    )
    
    login_as(user, :scope => :user)
    visit root_path
    click_on 'Fornecedores'
    click_on 'Vinícola Miolo'
    click_on 'Vinho Tinto Miolo'
    click_on 'Editar'

    fill_in 'Nome', with: 'Vinho Branco Miolo'
    fill_in 'Peso', with: '-801'
    fill_in 'Altura', with: ''
    fill_in 'Largura', with: '0'
    fill_in 'Profundidade', with: '-12'
    select 'Cerâmicas Geek', from: 'Fornecedor'
    select 'Bebidas', from: 'Categoria'
    click_on 'Salvar'

    expect(page).to have_content('Não foi possível atualizar o modelo de produto')
    expect(page).to have_content('Peso deve ser maior que 0')
    expect(page).to have_content('Altura não é um número')
    expect(page).to have_content('Altura não pode ficar em branco')
    expect(page).to have_content('Largura deve ser maior que 0')
    expect(page).to have_content('Profundidade deve ser maior que 0')
    expect(page).not_to have_content('Modelo de produto atualizado com sucesso')
    expect(page).not_to have_content('-801 gramas')
    expect(page).not_to have_content('Dimensões:  x 01 x -12')
    
  end

end