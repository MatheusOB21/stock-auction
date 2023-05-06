require 'rails_helper'

describe 'Usuário aprova um lote' do
  context 'mas não sendo admin' do
    it 'não possui acesso aos detalhes do lote' do
      #Arrange
        user_regular = User.create!(name: "Hélio", email: "hélio@leilaodohelio.com.br", password: "hélio_do_leilão", cpf:"50417550006")
        user_admin = User.create!(name: "Flávio", email: "flavio@leilaodogalpao.com.br", password: "flavio_do_leilão", cpf:"50534524079")
        lot = Lot.create!(code: "FRA456345", start_date: "28/05/2023", limit_date: "28/06/2023", minimal_val: 50, minimal_difference: 10, user: user_admin)
      #Act
        login_as(user_regular)
        visit lot_path(lot.id)
      #Assert
        expect(current_path).to eq root_path
        expect(page).to have_content "Você não tem acesso a essa página"      
    end
  end
  context 'sendo admin' do
    it 'e sendo ele que não criou, aprova com sucesso' do
      #Arrange
        user_admin = User.create!(name: "Flávio", email: "flavio@leilaodogalpao.com.br", password: "flavio_do_leilão", cpf:"50534524079")
        lot = Lot.create!(code: "FRA456345", start_date: "28/05/2023", limit_date: "28/06/2023", minimal_val: 50, minimal_difference: 10, user: user_admin)
        user_admin_2 = User.create!(name: "José", email: "jose@leilaodogalpao.com.br", password: "jose_do_leilão", cpf:"50417550006")
      #Act
        login_as(user_admin_2)
        visit root_path
        click_on 'Lotes pendentes'
        click_on 'FRA456345'
        click_on 'Aprovar lote'
      #Assert
        expect(current_path).to eq lot_path(lot.id)
        expect(page).to have_content "Lote aprovado com sucesso"
    end
    it 'e sendo ele que criou não aprova' do
      #Arrange
      user_admin = User.create!(name: "Flávio", email: "flavio@leilaodogalpao.com.br", password: "flavio_do_leilão", cpf:"50534524079")
      lot = Lot.create!(code: "FLA456345", start_date: "28/05/2023", limit_date: "28/06/2023", minimal_val: 50, minimal_difference: 10, user: user_admin)
    #Act
      login_as(user_admin)
      visit root_path
      click_on 'Lotes pendentes'
      click_on 'FLA456345'
      click_on 'Aprovar lote'
    #Assert
      expect(current_path).to eq lot_path(lot.id)
      expect(page).to have_content "Você não pode aprovar esse lote"
    end
  end
end