require 'rails_helper'

describe 'Usuario acessa a home page' do
  it 'a partir do link' do
      visit root_path
      click_on 'LEILÃO DE ESTOQUE'

      expect(current_path).to eq root_path
  end
  context 'sem autenticação' do
    it 'e acessa a pagina inicial' do
        visit root_path

        expect(page).to have_content "Bem vindo ao Leilão do Galpão"
    end
    it 'e visualiza os lotes para leilão' do
      user_admin = User.create!(name: "Flávio", email: "flavio@leilaodogalpao.com.br", password: "flavio_do_leilão", cpf:"50534524079")
      lot1 = Lot.create!(code: "FRA456345", start_date: Date.today, limit_date: 10.day.from_now, minimal_val: 50, minimal_difference: 10, user: user_admin, status: 'pending')
      lot2 = Lot.create!(code: "ZTZ456789", start_date: Date.today, limit_date: 5.day.from_now, minimal_val: 50, minimal_difference: 10, user: user_admin, status: 'aprovated')
      lot3 = Lot.create!(code: "RTX409055", start_date: Date.today, limit_date: 10.day.from_now, minimal_val: 50, minimal_difference: 10, user: user_admin, status: 'aprovated')
      lot4 = Lot.create!(code: "GTX166077", start_date: 5.day.from_now, limit_date: 15.day.from_now, minimal_val: 50, minimal_difference: 10, user: user_admin, status: 'aprovated')
      
      visit root_path

      expect(page).to have_content "Bem vindo ao Leilão do Galpão"
      expect(page).to have_content "Lotes em andamentos"
      expect(page).to have_content "ZTZ456789"
      expect(page).to have_content "RTX409055"
      expect(page).to have_content "Lotes futuros"
      expect(page).to have_content "GTX166077"
      expect(page).not_to have_content "FRA456345"
    end    
  end
  context 'com autenticação regular' do
    it 'e acessa a pagina inicial' do
        user = User.create!(name: 'Luke', email: 'luke@gmail.com', cpf:'08522429057', password: 'luke@12345')

        login_as(user)
        visit root_path

        expect(page).to have_content "Bem vindo ao Leilão do Galpão"
    end
    it 'e visualiza os lotes para leilão' do
      user = User.create!(name: 'Luke', email: 'luke@gmail.com', cpf:'08522429057', password: 'luke@12345')
      user_admin = User.create!(name: "Flávio", email: "flavio@leilaodogalpao.com.br", password: "flavio_do_leilão", cpf:"50534524079")
      lot1 = Lot.create!(code: "FRA456345", start_date: Date.today, limit_date: 10.day.from_now, minimal_val: 50, minimal_difference: 10, user: user_admin, status: 'pending')
      lot2 = Lot.create!(code: "ZTZ456789", start_date: Date.today, limit_date: 10.day.from_now, minimal_val: 50, minimal_difference: 10, user: user_admin, status: 'aprovated')
      lot3 = Lot.create!(code: "RTX409055", start_date: Date.today, limit_date: 15.day.from_now, minimal_val: 50, minimal_difference: 10, user: user_admin, status: 'aprovated')
      lot4 = Lot.create!(code: "GTX166077", start_date: 5.day.from_now, limit_date: 15.day.from_now, minimal_val: 50, minimal_difference: 10, user: user_admin, status: 'aprovated')

      login_as(user)
      visit root_path

      expect(page).to have_content "Bem vindo ao Leilão do Galpão"
      expect(page).to have_content "Lotes em andamentos"
      expect(page).to have_content "ZTZ456789"
      expect(page).to have_content "RTX409055"
      expect(page).to have_content "Lotes futuros"
      expect(page).to have_content "GTX166077"
      expect(page).not_to have_content "FRA456345"
    end  
  end
end