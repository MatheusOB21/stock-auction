require 'rails_helper'

describe 'Usuario cadastra um item:' do
    context 'Sendo usuário regular' do
      it 'não deve aparecer opção' do
      #Arrange
        user = User.create!(name: 'Maria', email: 'maria@hotmail.com',  password: 'maria1234', cpf:'94225136000')
      #Act
        login_as(user)
        visit root_path 
      #Assert
        expect(page).not_to have_link ('Cadastrar item')
      end
      it 'não é permitido' do
      #Arrange
        user = User.create!(name: 'Maria', email: 'maria@hotmail.com',  password: 'maria1234', cpf:'94225136000')
      #Act
        login_as(user)
        visit new_item_path 
      #Assert
        expect(current_path).to eq root_path  
        expect(page).to have_content "Você não tem acesso a essa página"
      end
    end
    
    context 'Sendo usuário administrador' do
      it 'deve aparecer opção e o formulário' do
      #Arrange
      user = User.create!(name: 'Maria', email: 'maria@leilaodogalpao.com.br', password: 'maria1234', cpf:'94225136000')
      #Act
        login_as(user)
        visit root_path
        click_on 'Cadastrar item'
      #Assert
        expect(page).to have_field 'Nome'  
        expect(page).to have_field 'Descrição'  
        expect(page).to have_field 'Peso'  
        expect(page).to have_field 'Largura'  
        expect(page).to have_field 'Altura' 
        expect(page).to have_field 'Profundidade'  
        expect(page).to have_field 'Imagem'  
        expect(page).to have_field 'Categoria do Produto' 
      end   
        
      it 'consegue cadastrar novo item com sucesso' do
      #Arrange
      user = User.create!(name: 'Maria', email: 'maria@leilaodogalpao.com.br', password: 'maria1234', cpf:'94225136000')
      #Act
        login_as(user)
        visit root_path
        click_on 'Cadastrar item'
        fill_in 'Nome', with: 'Smartphone Apple 13 Pro Max'
        fill_in 'Descrição', with: 'Celular top de linha da Apple'  
        fill_in 'Peso', with: '50'
        fill_in 'Largura', with: '10'  
        fill_in 'Altura' , with: '30'
        fill_in 'Profundidade' , with: '10'
        fill_in 'Categoria do Produto' , with: 'Celular'
        attach_file 'Image', Rails.root.join('spec/fixtures/test.png')  
        click_on 'Enviar'
      #Assert
        expect(current_path).to eq item_path(Item.last.id)
        expect(page).to have_content 'Item cadastrado com sucesso'
        expect(page).to have_content 'Nome: Smartphone Apple 13 Pro Max'
        expect(page).to have_content 'Descrição: Celular top de linha da Apple'
        expect(page).to have_content 'Peso: 50g'
        expect(page).to have_content 'Dimensões: 10 x 30 x 10 cm'
        expect(page).to have_content 'Categoria do Produto: Celular'
        expect(page).to have_content 'Imagem'
        expect(page).to have_css('img')
      end
    end
end