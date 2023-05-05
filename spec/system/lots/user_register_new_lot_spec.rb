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
    it 'não possui permisão para cadastrar' do
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
end