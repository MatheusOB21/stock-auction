require 'rails_helper'

describe 'Usuario acessa a home page' do
  context 'sem autenticação' do
    it 'acessa a pagina inicial' do
      #Arrange
  
      #Act
        visit root_path
      #Assert
        expect(page).to have_content "Bem vindo ao Leilão do Galpão"
    end
    
    it 'visualiza os lotes para leilão' do
      #Arrange
      user_admin = User.create!(name: "Flávio", email: "flavio@leilaodogalpao.com.br", password: "flavio_do_leilão", cpf:"50534524079")
      
      lot1 = Lot.create!(code: "FRA456345", start_date: "28/05/2023", limit_date: "28/06/2023", minimal_val: 50, minimal_difference: 10, user: user_admin, status: 'pending')
      
      #lot andamento
      lot2 = Lot.create!(code: "ZTZ456789", start_date: 10.day.ago, limit_date: 5.day.from_now, minimal_val: 50, minimal_difference: 10, user: user_admin, status: 'aprovated')
      lot3 = Lot.create!(code: "RTX409055", start_date: 5.day.ago, limit_date: 10.day.from_now, minimal_val: 50, minimal_difference: 10, user: user_admin, status: 'aprovated')
      
      #lot futuro
      lot4 = Lot.create!(code: "GTX166077", start_date: 5.day.from_now, limit_date: 15.day.from_now, minimal_val: 50, minimal_difference: 10, user: user_admin, status: 'aprovated')
      
      #Act
        visit root_path
      #Assert
        expect(page).to have_content "Bem vindo ao Leilão do Galpão"
        expect(page).to have_content "Lotes em andamentos"
        expect(page).to have_content "ZTZ456789"
        expect(page).to have_content "RTX409055"
        expect(page).to have_content "Lotes futuros"
        expect(page).to have_content "GTX166077"
  
        expect(page).not_to have_content "FRA456345"
    end    
    
    it 'e visualiza os detalhes de um lote e seus itens' do
      #Arrange
      user_admin = User.create!(name: "Flávio", email: "flavio@leilaodogalpao.com.br", password: "flavio_do_leilão", cpf:"50534524079")
      
      item = Item.create!(name: 'Ninja 2000', description: 'Uma moto verde, veloz e em ótimo estado', weight: 2000, depth: 1000, height: 1500, width: 300, product_category: 'Motocicleta')

      lot1 = Lot.create!(code: "ZTZ456789", start_date: 10.day.ago, limit_date: 5.day.from_now, minimal_val: 50, minimal_difference: 10, user: user_admin, status: 'aprovated')
      lot2 = Lot.create!(code: "GTX166077", start_date: 5.day.from_now, limit_date: 15.day.from_now, minimal_val: 50, minimal_difference: 10, user: user_admin, status: 'aprovated')
      
      lot_item = LotItem.create!(lot: lot2, item: item)
      #Act
        visit root_path
        click_on 'GTX166077'
      #Assert
        expect(page).to have_content "Detalhes do lote"
        expect(page).to have_content "Código"
        expect(page).to have_content "GTX166077"
        expect(page).to have_content "Data início"
        expect(page).to have_content "#{I18n.l(lot2.start_date)}"
        expect(page).to have_content "Data limite"
        expect(page).to have_content "#{I18n.l(lot2.limit_date)}"
        expect(page).to have_content "Valor mínimo de lance"
        expect(page).to have_content "50"
        expect(page).to have_content "Diferença mínima de lance"
        expect(page).to have_content "10"
        expect(page).to have_content "Items do lote"
        expect(page).to have_content "Ninja 2000"
        expect(page).to have_content "Uma moto verde, veloz e em ótimo estado"
        expect(page).to have_content "#{item.item_dimensions}"
  
        expect(page).not_to have_content "FRA456345"
    end    
    
    it 'mas não consegue visualizar detalhes de lotes pendentes' do
      #Arrange
      user_admin = User.create!(name: "Flávio", email: "flavio@leilaodogalpao.com.br", password: "flavio_do_leilão", cpf:"50534524079")
      
      item = Item.create!(name: 'Ninja 2000', description: 'Uma moto verde, veloz e em ótimo estado', weight: 2000, depth: 1000, height: 1500, width: 300, product_category: 'Motocicleta')

      lot = Lot.create!(code: "ZTZ456789", start_date: 10.day.ago, limit_date: 5.day.from_now, minimal_val: 50, minimal_difference: 10, user: user_admin, status: 'pending')
      
      lot_item = LotItem.create!(lot: lot, item: item)
      #Act
        visit lot_path(lot.id)
      #Assert
        expect(current_path).not_to eq lot_path(lot.id)
        expect(page).to have_content "Você não tem acesso a essa página"
    end
  end
  
  
  context 'com autenticação' do
    it 'acessa a pagina inicial' do
      #Arrange
        user = User.create!(name: 'Luke', email: 'luke@gmail.com', cpf:'08522429057', password: 'luke@12345')
      #Act
        login_as(user)
        visit root_path
      #Assert
        expect(page).to have_content "Bem vindo ao Leilão do Galpão"
    end
    
    it 'visualiza os lotes para leilão' do
      #Arrange
      user = User.create!(name: 'Luke', email: 'luke@gmail.com', cpf:'08522429057', password: 'luke@12345')
      user_admin = User.create!(name: "Flávio", email: "flavio@leilaodogalpao.com.br", password: "flavio_do_leilão", cpf:"50534524079")
      
      lot1 = Lot.create!(code: "FRA456345", start_date: "28/05/2023", limit_date: "28/06/2023", minimal_val: 50, minimal_difference: 10, user: user_admin, status: 'pending')
      
      #lot andamento
      lot2 = Lot.create!(code: "ZTZ456789", start_date: 10.day.ago, limit_date: 5.day.from_now, minimal_val: 50, minimal_difference: 10, user: user_admin, status: 'aprovated')
      lot3 = Lot.create!(code: "RTX409055", start_date: 5.day.ago, limit_date: 10.day.from_now, minimal_val: 50, minimal_difference: 10, user: user_admin, status: 'aprovated')
      
      #lot futuro
      lot4 = Lot.create!(code: "GTX166077", start_date: 5.day.from_now, limit_date: 15.day.from_now, minimal_val: 50, minimal_difference: 10, user: user_admin, status: 'aprovated')
      
      #Act
        login_as(user)
        visit root_path
      #Assert
        expect(page).to have_content "Bem vindo ao Leilão do Galpão"
        expect(page).to have_content "Lotes em andamentos"
        expect(page).to have_content "ZTZ456789"
        expect(page).to have_content "RTX409055"
        expect(page).to have_content "Lotes futuros"
        expect(page).to have_content "GTX166077"
  
        expect(page).not_to have_content "FRA456345"
    end  
    
    it 'e visualiza os detalhes de um lote e seus itens' do
      #Arrange
      user_admin = User.create!(name: "Flávio", email: "flavio@leilaodogalpao.com.br", password: "flavio_do_leilão", cpf:"50534524079")
      user_regular = User.create!(name: "Natália", email: "natalia@gmail.com.br", password: "natalia_do_leilão", cpf:"39451000038")
      
      item = Item.create!(name: 'Ninja 2000', description: 'Uma moto verde, veloz e em ótimo estado', weight: 2000, depth: 1000, height: 1500, width: 300, product_category: 'Motocicleta')

      lot1 = Lot.create!(code: "ZTZ456789", start_date: 10.day.ago, limit_date: 5.day.from_now, minimal_val: 50, minimal_difference: 10, user: user_admin, status: 'aprovated')
      lot2 = Lot.create!(code: "GTX166077", start_date: 5.day.from_now, limit_date: 15.day.from_now, minimal_val: 50, minimal_difference: 10, user: user_admin, status: 'aprovated')
      
      lot_item = LotItem.create!(lot: lot2, item: item)
      #Act
        login_as(user_regular)
        visit root_path
        click_on 'GTX166077'
      #Assert
        expect(page).to have_content "Detalhes do lote"
        expect(page).to have_content "Código"
        expect(page).to have_content "GTX166077"
        expect(page).to have_content "Data início"
        expect(page).to have_content "#{I18n.l(lot2.start_date)}"
        expect(page).to have_content "Data limite"
        expect(page).to have_content "#{I18n.l(lot2.limit_date)}"
        expect(page).to have_content "Valor mínimo de lance"
        expect(page).to have_content "50"
        expect(page).to have_content "Diferença mínima de lance"
        expect(page).to have_content "10"
        expect(page).to have_content "Items do lote"
        expect(page).to have_content "Ninja 2000"
        expect(page).to have_content "Uma moto verde, veloz e em ótimo estado"
        expect(page).to have_content "#{item.item_dimensions}"
  
        expect(page).not_to have_content "FRA456345"
    end  
    
    it 'mas não consegue visualizar detalhes de lotes pendentes' do
      #Arrange
      user_admin = User.create!(name: "Flávio", email: "flavio@leilaodogalpao.com.br", password: "flavio_do_leilão", cpf:"50534524079")
      user_regular = User.create!(name: "Natália", email: "natalia@gmail.com.br", password: "natalia_do_leilão", cpf:"39451000038")

      item = Item.create!(name: 'Ninja 2000', description: 'Uma moto verde, veloz e em ótimo estado', weight: 2000, depth: 1000, height: 1500, width: 300, product_category: 'Motocicleta')

      lot = Lot.create!(code: "ZTZ456789", start_date: 10.day.ago, limit_date: 5.day.from_now, minimal_val: 50, minimal_difference: 10, user: user_admin, status: 'pending')
      
      lot_item = LotItem.create!(lot: lot, item: item)
      #Act
        login_as(user_regular)
        visit lot_path(lot.id)
      #Assert
        expect(current_path).not_to eq lot_path(lot.id)
        expect(page).to have_content "Você não tem acesso a essa página"
    end
  end
end