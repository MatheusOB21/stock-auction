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
      it 'deve aparecer opção' do
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
        
      it 'deve aparecer opção' do
      #Arrange
      user = User.create!(name: 'Maria', email: 'maria@leilaodogalpao.com.br', password: 'maria1234', cpf:'94225136000')
      #Act
        login_as(user)
        visit root_path
      #Assert
        expect(page).to have_link ('Cadastrar item')        
      end
    end
end