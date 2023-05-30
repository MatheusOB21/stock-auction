require 'rails_helper'

describe 'Usuário administrador ve lotes que passaram da data limite' do
  it 'a partir do link na tela do menu' do
    user_admin = User.create!(name: "Flávio", email: "flavio@leilaodogalpao.com.br", password: "flavio_do_leilão", cpf:"50534524079")
    lot1 = Lot.create!(code: "FRA456345", start_date: Date.today, limit_date: 10.day.from_now, minimal_val: 50, minimal_difference: 10, user: user_admin)
    lot2 = Lot.create!(code: "ZFA123456", start_date: 1.day.from_now, limit_date: 15.day.from_now, minimal_val: 50, minimal_difference: 10, user: user_admin)
    lot3 = Lot.create!(code: "TRA456345", start_date: 1.day.from_now, limit_date: 15.day.from_now, minimal_val: 50, minimal_difference: 10, user: user_admin, status: 'aprovated')
    lot4 = Lot.create!(code: "GHZ123789", start_date: 2.day.from_now, limit_date: 10.day.from_now, minimal_val: 50, minimal_difference: 10, user: user_admin, status: 'aprovated')
   
    login_as(user_admin)
    visit root_path
    
    expect(page).to have_link "Lotes finalizados"    
  end
  it 'com sucesso' do
      user_admin = User.create!(name: "Flávio", email: "flavio@leilaodogalpao.com.br", password: "flavio_do_leilão", cpf:"50534524079")
      Lot.create!(code: "FRA456345", start_date: 1.day.from_now, limit_date: 10.day.from_now, minimal_val: 50, minimal_difference: 10, user: user_admin)
      Lot.create!(code: "ZFA123456", start_date: 2.day.from_now, limit_date: 10.day.from_now, minimal_val: 50, minimal_difference: 10, user: user_admin)
      travel_to 30.day.ago do
        Lot.create!(code: "TRA456345", start_date: Date.current, limit_date: 15.day.from_now, minimal_val: 50, minimal_difference: 10, user: User.last, status: 'aprovated')
        Lot.create!(code: "GHZ123789", start_date: Date.current, limit_date: 10.day.from_now, minimal_val: 50, minimal_difference: 10, user: User.last, status: 'aprovated')
      end

      login_as(user_admin)
      visit root_path
      click_on "Lotes finalizados"

      expect(current_path).to eq finished_lots_path
      expect(page).to have_content "TRA456345"      
      expect(page).to have_content "GHZ123789"               
      
      expect(page).not_to have_content "FRA456345"      
      expect(page).not_to have_content "ZFA123456"      
  end
end