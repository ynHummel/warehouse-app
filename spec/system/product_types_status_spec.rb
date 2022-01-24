require 'rails_helper'

describe 'User enters in the product type details page' do
  it 'and sees the status and change buton' do
    cat = ProductCategory.create!(name: 'Test')
    pt = create(:product_type, product_category: cat)
    
    visit product_type_path(pt.id)
    
    expect(page).to have_css('h2', text:'Status do produto:')
    expect(page).to have_content('Disponível para venda')
    expect(page).to have_button('Tornar insdisponível')
  end

  it 'and change it\'s status to unsellable' do
    cat = ProductCategory.create!(name: 'Test')
    pt = create(:product_type, product_category: cat)
    
    visit product_type_path(pt.id)
    click_on 'Tornar insdisponível'

    expect(page).to have_css('h2', text:'Status do produto:')
    expect(page).to have_content('Indisponível para venda')
    expect(page).to have_button('Disponibilizar')
  end

  it 'and can turn a unsellable product into sellable' do
    cat = ProductCategory.create!(name: 'Test')
    pt = create(:product_type, product_category: cat)
    pt.unsellable!
    
    visit product_type_path(pt.id)
    click_on 'Disponibilizar'

    expect(page).to have_css('h2', text:'Status do produto:')
    expect(page).to have_content('Disponível para venda')
    expect(page).to have_button('Tornar insdisponível')
  end

end