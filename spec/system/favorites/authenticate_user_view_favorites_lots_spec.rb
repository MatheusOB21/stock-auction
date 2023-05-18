require 'rails_helper'

describe 'Usuário autenticado vê os lotes favoritos' do

  it 'e apenas se estiver autenticado' do
    #Arrange
      user_admin = User.create!(name: "Flávio", email: "flavio@leilaodogalpao.com.br", password: "flavio_do_leilão", cpf:"50534524079")

      item = Item.create!(name: 'Ninja 2000', description: 'Uma moto verde, veloz e em ótimo estado', weight: 2000, depth: 1000, height: 1500, width: 300, product_category: 'Motocicleta')
      lot = Lot.create!(code: "ZTZ456789", start_date: Date.today, limit_date: 10.day.from_now, minimal_val: 50, minimal_difference: 10, user: user_admin, status: 'aprovated')
      lot_item = LotItem.create!(lot: lot, item: item)
    #Act
      visit favorites_path
    #Assert
      expect(current_path).to eq new_user_session_path     
  end
  
  it 'a partir do link do menu' do
    #Arrange
      user_admin = User.create!(name: "Flávio", email: "flavio@leilaodogalpao.com.br", password: "flavio_do_leilão", cpf:"50534524079")
      user = User.create!(name: 'Luke', email: 'luke@gmail.com', cpf:'08522429057', password: 'luke@12345')

      item = Item.create!(name: 'Ninja 2000', description: 'Uma moto verde, veloz e em ótimo estado', weight: 2000, depth: 1000, height: 1500, width: 300, product_category: 'Motocicleta')
      lot = Lot.create!(code: "ZTZ456789", start_date: Date.today, limit_date: 10.day.from_now, minimal_val: 50, minimal_difference: 10, user: user_admin, status: 'aprovated')
      lot_item = LotItem.create!(lot: lot, item: item)
    #Act
      login_as(user)
      visit root_path
    #Assert
      expect(page).to have_link 'Lotes favoritos'    
  end
  
  it 'com sucesso' do
    #Arrange
      user_admin = User.create!(name: "Flávio", email: "flavio@leilaodogalpao.com.br", password: "flavio_do_leilão", cpf:"50534524079")
      user = User.create!(name: 'Luke', email: 'luke@gmail.com', cpf:'08522429057', password: 'luke@12345')

      item = Item.create!(name: 'Ninja 2000', description: 'Uma moto verde, veloz e em ótimo estado', weight: 2000, depth: 1000, height: 1500, width: 300, product_category: 'Motocicleta')
      lot = Lot.create!(code: "ZTZ456789", start_date: Date.today, limit_date: 10.day.from_now, minimal_val: 50, minimal_difference: 10, user: user_admin, status: 'aprovated')
      lot_item = LotItem.create!(lot: lot, item: item)

      Favorite.create!(lot: lot, user: user)
    #Act
      login_as(user)
      visit root_path
      click_on 'Lotes favoritos'
    #Assert
      expect(page).to have_content 'ZTZ456789'    
      expect(page).to have_content "#{lot.start_date}"    
      expect(page).to have_content "#{lot.limit_date}"      
  end
  
  it 'com sucesso, e mostra o status do lot' do
    #Arrange
      user_admin = User.create!(name: "Flávio", email: "flavio@leilaodogalpao.com.br", password: "flavio_do_leilão", cpf:"50534524079")
      user = User.create!(name: 'Luke', email: 'luke@gmail.com', cpf:'08522429057', password: 'luke@12345')

      item = Item.create!(name: 'Ninja 2000', description: 'Uma moto verde, veloz e em ótimo estado', weight: 2000, depth: 1000, height: 1500, width: 300, product_category: 'Motocicleta')
      
      lot1 = Lot.create!(code: "ZTZ456789", start_date: Date.today, limit_date: 10.day.from_now, minimal_val: 50, minimal_difference: 10, user: user_admin, status: 'aprovated')
      
      travel_to 20.day.ago do
        Lot.create!(code: "AFS123456", start_date: Date.today, limit_date: 10.day.from_now, minimal_val: 50, minimal_difference: 10, user: user_admin, status: 'aprovated')
      end
      lot2 = Lot.last
      
      lot_item = LotItem.create!(lot: lot1, item: item)

      Favorite.create!(lot: lot1, user: user)
      Favorite.create!(lot: lot2, user: user)
    #Act
      login_as(user)
      visit root_path
      click_on 'Lotes favoritos'
    #Assert
      expect(page).to have_content 'Lote em andamento'    
      expect(page).to have_content "Lote encerrado"    

  end
  
  it 'com sucesso, e mostra os detalhes do lot' do
    #Arrange
      user_admin = User.create!(name: "Flávio", email: "flavio@leilaodogalpao.com.br", password: "flavio_do_leilão", cpf:"50534524079")
      user = User.create!(name: 'Luke', email: 'luke@gmail.com', cpf:'08522429057', password: 'luke@12345')

      item = Item.create!(name: 'Ninja 2000', description: 'Uma moto verde, veloz e em ótimo estado', weight: 2000, depth: 1000, height: 1500, width: 300, product_category: 'Motocicleta')
      
      lot = Lot.create!(code: "ZTZ456789", start_date: Date.today, limit_date: 10.day.from_now, minimal_val: 200, minimal_difference: 100, user: user_admin, status: 'aprovated')
      
      lot_item = LotItem.create!(lot: lot, item: item)

      Favorite.create!(lot: lot, user: user)
    #Act
      login_as(user)
      visit root_path
      click_on 'Lotes favoritos'
      click_on 'ZTZ456789'
    #Assert
      expect(current_path).to eq lot_path(lot)
      expect(page).to have_content "Detalhes do lote"
      expect(page).to have_content "Código"
      expect(page).to have_content "ZTZ456789"
      expect(page).to have_content "Data início"
      expect(page).to have_content "#{I18n.l(lot.start_date)}"
      expect(page).to have_content "Data limite"
      expect(page).to have_content "#{I18n.l(lot.limit_date)}"
      expect(page).to have_content "Valor mínimo de lance"
      expect(page).to have_content "200"
      expect(page).to have_content "Diferença mínima de lance"
      expect(page).to have_content "100"
  
  end

end