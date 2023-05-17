require 'rails_helper'

describe 'Usuario vê todos os items cadastrados' do
  context 'sendo admin' do
    it 'a partir do menu' do
      #Arrange
      user_admin = User.create!(name: 'Maria', email: 'maria@leilaodogalpao.com.br', password: 'maria1234', cpf:'94225136000')

      #Act
      login_as(user_admin)
      visit root_path

      #Assert
      expect(page).to have_content 'Itens cadastrados'
    end
  end
end