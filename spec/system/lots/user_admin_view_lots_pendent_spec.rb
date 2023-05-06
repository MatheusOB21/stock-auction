require 'rails_helper'

describe 'Usuário admin vê os lotes pendentes' do
    it 'com sucesso' do
      #Arrange
        user_admin = User.create!(name: "Flávio", email: "flavio@leilaodogalpao.com.br", password: "flavio_do_leilão", cpf:"50534524079")
        lot = Lot.create!(code: "FRA456345", start_date: "28/05/2023", limit_date: "28/06/2023", minimal_val: 50, minimal_difference: 10, user: user_admin)
        lot2 = Lot.create!(code: "TRA456345", start_date: "24/07/2023", limit_date: "15/09/2023", minimal_val: 50, minimal_difference: 10, user: user_admin, status: 'aprovated')
      #Act
        login_as(user_admin)
        visit root_path
        click_on "Lotes pendentes"
      #Assert
        expect(current_path).to eq pendents_lots_path
        expect(page).to have_content "FRA456345"      
        expect(page).to have_content "28/05/2023"      
        expect(page).to have_content "28/05/2023"      
        expect(page).not_to have_content "TRA456345"      
        expect(page).not_to have_content "24/07/2023"      
        expect(page).not_to have_content "15/09/2023"      
    end
    it 'e vê detalhes do lote' do
      #Arrange
        user_admin = User.create!(name: "Flávio", email: "flavio@leilaodogalpao.com.br", password: "flavio_do_leilão", cpf:"50534524079")
        lot = Lot.create!(code: "FRA456345", start_date: "28/05/2023", limit_date: "28/06/2023", minimal_val: 50, minimal_difference: 10, user: user_admin)
      #Act
        login_as(user_admin)
        visit root_path
        click_on "Lotes pendentes"
        click_on "FRA456345"
      #Assert
        expect(current_path).to eq lot_path(lot.id)
        expect(page).to have_content "FRA456345"      
        expect(page).to have_content "28/05/2023"      
        expect(page).to have_content "28/05/2023"      
        expect(page).to have_content "50"      
        expect(page).to have_content "10"      
    end
    it 'e não tem nenhum lote pendente' do
      #Arrange
        user_admin = User.create!(name: "Flávio", email: "flavio@leilaodogalpao.com.br", password: "flavio_do_leilão", cpf:"50534524079")
      #Act
        login_as(user_admin)
        visit root_path
        click_on "Lotes pendentes"
      #Assert
        expect(page).to have_content "Nenhun lote pendente de aprovação"      
    end
end