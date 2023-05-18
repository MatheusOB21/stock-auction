require 'rails_helper'

describe 'Usuário admin edita item' do
  
  it 'a partir dos detalhes de item' do
    #Arrange
      user_admin = User.create!(name: 'Maria', email: 'maria@leilaodogalpao.com.br', password: 'maria1234', cpf:'94225136000')
      Item.create!(name: 'Yamaha 200', description: 'Uma moto verde, veloz e em ótimo estado', weight: 2000, depth: 1000, height: 1500, width: 300, product_category: 'Motocicleta')

    #Act
      login_as(user_admin)
      visit root_path
      click_on 'Itens disponíveis'
      within("#1") do
        click_on 'Editar'
      end
    #Assert
      expect(current_path).to eq edit_item_path(Item.last)
      expect(page).to have_field 'Nome', with: 'Yamaha 200'
      expect(page).to have_field 'Descrição', with:'Uma moto verde, veloz e em ótimo estado'
      expect(page).to have_field 'Peso', with: '2000'
      expect(page).to have_field 'Profundidade', with: '1000'
      expect(page).to have_field 'Altura', with: '1500'
      expect(page).to have_field 'Categoria do Produto', with: 'Motocicleta' 
      expect(page).to have_field 'Imagem' 
  end
  
  it 'com sucesso' do
    #Arrange
      user_admin = User.create!(name: 'Maria', email: 'maria@leilaodogalpao.com.br', password: 'maria1234', cpf:'94225136000')
      item = Item.create!(name: 'Yamaha 200', description: 'Uma moto verde, veloz e em ótimo estado', weight: 2000, depth: 1000, height: 1500, width: 300, product_category: 'Motocicleta')

    #Act
      login_as(user_admin)
      visit root_path
      click_on 'Itens disponíveis'
      within("#1") do
        click_on 'Editar'
      end
      fill_in 'Nome', with: 'Yamaha 200'
      fill_in 'Descrição', with:'Uma moto azul, devagar e em estado médio'
      fill_in 'Peso', with: '3000'
      fill_in 'Profundidade', with: '2000'
      fill_in 'Altura', with: '4000'
      fill_in 'Categoria do Produto', with: 'Motocicleta' 
      click_on 'Enviar'
    #Assert
      expect(current_path).to eq item_path(item)
      expect(page).to have_content 'Yamaha 200'
      expect(page).to have_content 'Uma moto azul, devagar e em estado médio'
      expect(page).to have_content '3000'
      expect(page).to have_content '2000'
      expect(page).to have_content '4000'
      expect(page).to have_content 'Motocicleta' 
  end

end