require 'rails_helper'

describe 'Usuario admin ve os lotes' do
  it 'que ja passaram da data limite' do
      #Arrange
        user_admin = User.create!(name: "Flávio", email: "flavio@leilaodogalpao.com.br", password: "flavio_do_leilão", cpf:"50534524079")
        lot1 = Lot.create!(code: "FRA456345", start_date: "28/05/2023", limit_date: "28/06/2023", minimal_val: 50, minimal_difference: 10, user: user_admin)
        lot2 = Lot.create!(code: "ZFA123456", start_date: "24/07/2023", limit_date: "15/09/2023", minimal_val: 50, minimal_difference: 10, user: user_admin)
        
        lot3 = Lot.create!(code: "TRA456345", start_date: 10.day.ago, limit_date: 5.day.ago, minimal_val: 50, minimal_difference: 10, user: user_admin, status: 'aprovated')
        lot4 = Lot.create!(code: "GHZ123789", start_date: 20.day.ago, limit_date: 10.day.ago, minimal_val: 50, minimal_difference: 10, user: user_admin, status: 'aprovated')
      #Act
        login_as(user_admin)
        visit root_path
        click_on "Lotes finalizados"
      #Assert
        expect(current_path).to eq finalized_lots_path
        expect(page).to have_content "TRA456345"      
        expect(page).to have_content "GHZ123789"               
        expect(page).not_to have_content "FRA456345"      
        expect(page).not_to have_content "ZFA123456"      
  end
end