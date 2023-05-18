require 'rails_helper'

describe 'Usuário admin edita item' do

  context 'e sendo' do

    it 'usuario sem autenticação não edita' do
      #Arrange
        item = Item.create!(name: 'Yamaha 200', description: 'Uma moto verde, veloz e em ótimo estado', weight: 2000, depth: 1000, height: 1500, width: 300, product_category: 'Motocicleta')
      #Act
        visit edit_item_path(item)
      #Assert
        expect(current_path).not_to eq edit_item_path(Item.last)
        expect(current_path).to eq new_user_session_path       
    end

    it 'usuario regular autenticado não edita' do
      #Arrange
        user_regular = User.create!(name: "Gabriel", email: "gabriel@gmail.com.br", password: "gabriel123", cpf:"04209958034")
        item = Item.create!(name: 'Yamaha 200', description: 'Uma moto verde, veloz e em ótimo estado', weight: 2000, depth: 1000, height: 1500, width: 300, product_category: 'Motocicleta')
      #Act
        login_as(user_regular)
        visit edit_item_path(item)
      #Assert
        expect(current_path).not_to eq edit_item_path(Item.last)
        expect(current_path).to eq root_path
        expect(page).to have_content 'Você não tem acesso a essa página' 
    end

  end
  
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
  
  it 'sem sucesso, pois deixa campo em branco' do
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
      fill_in 'Descrição', with:''
      fill_in 'Peso', with: '3000'
      fill_in 'Profundidade', with: ''
      fill_in 'Altura', with: '4000'
      fill_in 'Categoria do Produto', with: 'Motocicleta' 
      click_on 'Enviar'
    #Assert
      expect(page).to have_content 'Item não pode ser editado'
      expect(page).to have_content 'Descrição não pode ficar em branco'
      expect(page).to have_content 'Profundidade não pode ficar em branco'
  end

end