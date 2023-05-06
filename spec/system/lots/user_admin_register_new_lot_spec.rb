require 'rails_helper'

describe 'Usário cadastra um novo lote:' do
  context 'Usuário regular' do
    it 'não possui link para cadastrar' do
      #Arrange
        user = User.create!(name: "Hélio", email: "hélio@leilaodohelio.com.br", password: "hélio_do_leilão", cpf:"50417550006")
      #Act
        login_as(user)
        visit root_path
      #Assert
        expect(page).not_to have_content "Cadastrar lote"
    end
    it 'não tem permisão para cadastrar' do
      #Arrange
        user = User.create!(name: "Hélio", email: "hélio@leilaodohelio.com.br", password: "hélio_do_leilão", cpf:"50417550006")
      #Act
        login_as(user)
        visit new_lot_path
      #Assert
        expect(current_path).to eq root_path
        expect(page).to have_content "Você não tem acesso a essa página"
    end
  end
  context 'Usuário admin' do
      it 'possui o link para cadastrar' do
      #Arrange
        user = User.create!(name: "Ribamar", email: "ribamar@leilaodogalpao.com.br", password: "ribamar_do_leilão", cpf:"50417550006")
      #Act
        login_as(user)
        visit root_path
      #Assert
        expect(page).to have_content "Cadastrar lote"        
      end
      it 'tem permissão para cadastrar' do
      #Arrange
        user = User.create!(name: "Ribamar", email: "ribamar@leilaodogalpao.com.br", password: "ribamar_do_leilão", cpf:"50417550006")
      #Act
        login_as(user)
        visit new_lot_path
      #Assert
        expect(page).to have_content "Cadastrar novo lote"        
        expect(page).to have_field "Código"        
        expect(page).to have_field "Data início"        
        expect(page).to have_field "Data limite"        
        expect(page).to have_field "Valor mínimo de lance"        
        expect(page).to have_field "Diferença mínima de lance"        
        expect(page).to have_button "Enviar"        
      end
      it 'cadastra com sucesso' do
      #Arrange
        user = User.create!(name: "Ribamar", email: "ribamar@leilaodogalpao.com.br", password: "ribamar_do_leilão", cpf:"50417550006")
      #Act
        login_as(user)
        visit root_path
        click_on "Cadastrar lote"     
        fill_in "Código", with:  "FRA456345"      
        fill_in "Data início", with: "28/05/2023"       
        fill_in "Data limite", with: "25/06/2023"       
        fill_in "Valor mínimo de lance", with: "60"       
        fill_in "Diferença mínima de lance", with: "10"        
        click_on "Enviar"
      #Assert
        expect(current_path).to eq lot_path(Lot.last.id)
        expect(Lot.last.user_id).to eq user.id
        expect(page).to have_content "Lote cadastrado com sucesso"
        expect(page).to have_content "Detalhes do lote"
        expect(page).to have_content "Código FRA456345 "
        expect(page).to have_content "Data início 28/05/2023"
        expect(page).to have_content "Data limite 25/06/2023"
        expect(page).to have_content "Valor mínimo de lance: 60"
        expect(page).to have_content "Diferença mínima de lance: 10"
      end
  end
end