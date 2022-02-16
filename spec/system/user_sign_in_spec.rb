require 'rails_helper'

describe 'User Login' do
  it 'successfully' do
    User.create!(email: 'yuri@email.com', password: '12345678')

    visit root_path
    within 'div.ls-notification-topbar' do
      click_on 'Entrar'
    end
    fill_in 'E-mail', with: 'yuri@email.com'
    fill_in 'Senha', with: '12345678'
    click_on 'Log in'

    expect(current_path).to eq root_path
    expect(page).not_to have_link 'Entrar'
    expect(page).to have_link 'Sair'
    expect(page).to have_content 'Olá yuri@email.com'
  end

  it 'and logout' do
    User.create!(email: 'yuri@email.com', password: '12345678')

    visit root_path
    within 'div.ls-notification-topbar' do
      click_on 'Entrar'
    end
    fill_in 'E-mail', with: 'yuri@email.com'
    fill_in 'Senha', with: '12345678'
    click_on 'Log in'
    within 'div.ls-notification-topbar' do
      click_on 'Sair'
    end

    expect(current_path).to eq root_path
    expect(page).to have_link 'Entrar'
    expect(page).not_to have_link 'Sair'
    expect(page).not_to have_content 'Olá yuri@email.com'
  end
end
