require 'rails_helper'

describe 'Usuário admin vê os lotes pendentes' do
    it 'com sucesso' do
        user_admin = User.create!(name: "Flávio", email: "flavio@leilaodogalpao.com.br", password: "flavio_do_leilão", cpf:"50534524079")
        lot1 = Lot.create!(code: "FRA456345", start_date: Date.today, limit_date: 15.day.from_now, minimal_val: 50, minimal_difference: 10, user: user_admin)
        lot2 = Lot.create!(code: "TRA456345", start_date: 5.day.from_now, limit_date: 20.day.from_now, minimal_val: 50, minimal_difference: 10, user: user_admin, status: 'aprovated')

        login_as(user_admin)
        visit root_path
        click_on "Lotes pendentes"

        expect(current_path).to eq pendents_lots_path
        expect(page).to have_content "FRA456345"      
        expect(page).to have_content "#{I18n.l(lot1.start_date)}"      
        expect(page).to have_content "#{I18n.l(lot1.limit_date)}"      
        expect(page).not_to have_content "TRA456345"      
        expect(page).not_to have_content "#{I18n.l(lot2.start_date)}"      
        expect(page).not_to have_content "#{I18n.l(lot2.limit_date)}"      
    end
    
    it 'e vê detalhes do lote' do
        user_admin = User.create!(name: "Flávio", email: "flavio@leilaodogalpao.com.br", password: "flavio_do_leilão", cpf:"50534524079")
        lot = Lot.create!(code: "FRA456345", start_date: Date.today, limit_date: 10.day.from_now, minimal_val: 50, minimal_difference: 10, user: user_admin)

        login_as(user_admin)
        visit root_path
        click_on "Lotes pendentes"
        click_on "FRA456345"

        expect(current_path).to eq lot_path(lot.id)
        expect(page).to have_content "FRA456345"      
        expect(page).to have_content "#{I18n.l(lot.start_date)}"      
        expect(page).to have_content "#{I18n.l(lot.limit_date)}"      
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
        expect(page).to have_content "Nenhum lote pendente de aprovação"      
    end
end