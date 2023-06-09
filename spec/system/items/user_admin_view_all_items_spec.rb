require 'rails_helper'

describe 'Usuario vê os itens disponíveis' do
  context  'e sendo usuário administrador' do
      it 'vê partir do menu' do
        user_admin = User.create!(name: 'Maria', email: 'maria@leilaodogalpao.com.br', password: 'maria1234', cpf:'94225136000')

        login_as(user_admin)
        visit root_path

        expect(page).to have_content 'Itens disponíveis'
      end
      it 'vê com sucesso' do
        user_admin = User.create!(name: 'Maria', email: 'maria@leilaodogalpao.com.br', password: 'maria1234', cpf:'94225136000')
        Item.create!(name: 'Fazer 500', description: 'Uma moto verde, veloz e em ótimo estado', weight: 2000, depth: 1000, height: 1500, width: 300, product_category: 'Motocicleta')
        Item.create!(name: 'Guitarra Michael Les Paul Preto', description: 'Uma guitarra preta, em ótimo estado', weight: 2000, depth: 900, height: 400, width: 500, product_category: 'Motocicleta')
        Item.create!(name: 'Ferrari', description: 'Um carro vermelho e veloz', weight: 2000, depth: 100, height: 150, width: 400, product_category: 'Motocicleta')
        Item.create!(name: 'BMW', description: 'Carro de alta classe', weight: 2000, depth: 1000, height: 1500, width: 300, product_category: 'Motocicleta')

        login_as(user_admin)
        visit root_path
        click_on 'Itens disponíveis'

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
      it 'vê, mas não tem itens cadastrados' do
        user_admin = User.create!(name: 'Maria', email: 'maria@leilaodogalpao.com.br', password: 'maria1234', cpf:'94225136000')

        login_as(user_admin)
        visit root_path
        click_on 'Itens disponíveis'

        expect(current_path).to eq items_path
        expect(page).to have_content 'Nenhum item atualmente disponível para adicionar em lote'
      end
  end

  context 'e sendo usuário regular' do
    it 'autenticado, não tem acesso' do
      user_regular = User.create!(name: 'Maria', email: 'maria@gmail.com.br', password: 'maria123456789', cpf:'94225136000')

      login_as(user_regular)
      visit items_path

      expect(current_path).to eq root_path
      expect(page).to have_content "Você não tem acesso a essa página"
    end
    it 'e sem autenticação, não tem acesso' do
      user_regular = User.create!(name: 'Maria', email: 'maria@gmail.com.br', password: 'maria123456789', cpf:'94225136000')
        
      visit items_path
        
      expect(current_path).to eq new_user_session_path
    end
  end
end