require 'rails_helper'

describe 'Usuario vê todos os itens disponíveis' do
  
  context 'sendo admin,' do

    it 'a partir do menu' do
      #Arrange
      user_admin = User.create!(name: 'Maria', email: 'maria@leilaodogalpao.com.br', password: 'maria1234', cpf:'94225136000')

      #Act
      login_as(user_admin)
      visit root_path

      #Assert
      expect(page).to have_content 'Itens disponíveis'
    end

    it 'com sucesso' do
      #Arrange
      user_admin = User.create!(name: 'Maria', email: 'maria@leilaodogalpao.com.br', password: 'maria1234', cpf:'94225136000')
      Item.create!(name: 'Fazer 500', description: 'Uma moto verde, veloz e em ótimo estado', weight: 2000, depth: 1000, height: 1500, width: 300, product_category: 'Motocicleta')
      Item.create!(name: 'Guitarra Michael Les Paul Preto', description: 'Uma guitarra preta, em ótimo estado', weight: 2000, depth: 900, height: 400, width: 500, product_category: 'Motocicleta')
      Item.create!(name: 'Ferrari', description: 'Um carro vermelho e veloz', weight: 2000, depth: 100, height: 150, width: 400, product_category: 'Motocicleta')
      Item.create!(name: 'BMW', description: 'Carro de alta classe', weight: 2000, depth: 1000, height: 1500, width: 300, product_category: 'Motocicleta')

      #Act
      login_as(user_admin)
      visit root_path
      click_on 'Itens disponíveis'
      #Assert
      expect(current_path).to eq items_path
      expect(page).to have_content 'Fazer 500'
      expect(page).to have_content '300 x 1500 x 1000 cm'
      expect(page).to have_content 'Guitarra Michael Les Paul Preto'
      expect(page).to have_content '500 x 400 x 900 cm'
      expect(page).to have_content 'Ferrari'
      expect(page).to have_content '400 x 150 x 100 cm'
      expect(page).to have_content 'BMW'
      expect(page).to have_content '300 x 1500 x 1000 cm'
    end
    
  end

  context 'não sendo admin,' do

    it 'não tem acesso' do
      
      #Arrange
      user_regular = User.create!(name: 'Maria', email: 'maria@gmail.com.br', password: 'maria123456789', cpf:'94225136000')
      
      #Act
      login_as(user_regular)
      visit items_path
      
      #Assert
      expect(current_path).to eq root_path
      expect(page).to have_content "Você não tem acesso a essa página"

    end
  end
end