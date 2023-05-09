require 'rails_helper'

describe 'Usuário regular da um lance' do
  
  it 'a partir da tela de detalhes do lote' do
    #Arrange
      user_admin = User.create!(name: "Flávio", email: "flavio@leilaodogalpao.com.br", password: "flavio_do_leilão", cpf:"50534524079")
      
      item = Item.create!(name: 'Ninja 2000', description: 'Uma moto verde, veloz e em ótimo estado', weight: 2000, depth: 1000, height: 1500, width: 300, product_category: 'Motocicleta')

      lot = Lot.create!(code: "GTX166077", start_date: 5.day.ago, limit_date: 5.day.from_now, minimal_val: 50, minimal_difference: 10, user: user_admin, status: 'aprovated')
      
      lot_item = LotItem.create!(lot: lot, item: item)
    #Act
      visit root_path
      click_on 'GTX166077'
    #Assert
      expect(page).to have_content "Detalhes do lote"
      expect(page).to have_content "Código"
      expect(page).to have_content "GTX166077"
      expect(page).to have_content "Lances"
      expect(page).to have_field "Valor do lance"
      expect(page).to have_button "Dar lance"
  end
  
  it 'e precisa estar autenticado' do
    #Arrange
      user_admin = User.create!(name: "Flávio", email: "flavio@leilaodogalpao.com.br", password: "flavio_do_leilão", cpf:"50534524079")
        
      item = Item.create!(name: 'Ninja 2000', description: 'Uma moto verde, veloz e em ótimo estado', weight: 2000, depth: 1000, height: 1500, width: 300, product_category: 'Motocicleta')
      lot = Lot.create!(code: "RTX206000", start_date: 5.day.ago, limit_date: 15.day.from_now, minimal_val: 200, minimal_difference: 50, user: user_admin, status: 'aprovated')
      lot_item = LotItem.create!(lot: lot, item: item)

    #Act
      visit root_path
      click_on 'RTX206000'
      fill_in 'Valor do lance', with: '199'
      click_on 'Dar lance'
    #Assert
      expect(current_path).to eq new_user_session_path
      expect(page).to have_content 'Para continuar, faça login ou registre-se.'
  end
  
  it 'é o primeiro do lote' do
    
  end

  it 'sem sucesso, pois informa valor inferior ao valor mínimo' do
    #Arrange
      user_admin = User.create!(name: "Flávio", email: "flavio@leilaodogalpao.com.br", password: "flavio_do_leilão", cpf:"50534524079")
      user_regular = User.create!(name: "Jose", email: "jose@gmail.com.br", password: "jose12345", cpf:"09036567017")
        
      item = Item.create!(name: 'Ninja 2000', description: 'Uma moto verde, veloz e em ótimo estado', weight: 2000, depth: 1000, height: 1500, width: 300, product_category: 'Motocicleta')
  
      lot = Lot.create!(code: "RTX206000", start_date: 5.day.ago, limit_date: 15.day.from_now, minimal_val: 200, minimal_difference: 50, user: user_admin, status: 'aprovated')
        
      lot_item = LotItem.create!(lot: lot, item: item)
    #Act
      login_as(user_regular)
      visit root_path
      click_on 'RTX206000'
      fill_in 'Valor do lance', with: '199'
      click_on 'Dar lance'
    #Assert
      expect(page).to have_content 'Lance não computado'
      expect(page).to have_content 'Valor do lance precisa ser maior que R$200.0'

  end
  
  it 'sem sucesso, pois informa valor inferior a diferença minima' do
    #Arrange
      user_admin = User.create!(name: "Flávio", email: "flavio@leilaodogalpao.com.br", password: "flavio_do_leilão", cpf:"50534524079")
      
      user_regular1 = User.create!(name: "Katarina", email: "katarina@gmail.com.br", password: "katarina12345", cpf:"09036567017")
      user_regular2 = User.create!(name: "Michael", email: "michael@gmail.com.br", password: "michael12345", cpf:"64975225069")
        
      item = Item.create!(name: 'Ninja 2000', description: 'Uma moto verde, veloz e em ótimo estado', weight: 2000, depth: 1000, height: 1500, width: 300, product_category: 'Motocicleta')

      lot = Lot.create!(code: "RTX306000", start_date: 5.day.ago, limit_date: 15.day.from_now, minimal_val: 200, minimal_difference: 50, user: user_admin, status: 'aprovated')
        
      lot_item = LotItem.create!(lot: lot, item: item)
      
      UserBidLot.create!(lot: lot, user: user_regular1, bid_amount: 250)
    #Act
      login_as(user_regular2)
      visit root_path
      click_on 'RTX306000'
      fill_in 'Valor do lance', with: '230'
      click_on 'Dar lance'
    #Assert
      expect(page).to have_content 'Lance não computado'
      expect(page).to have_content 'Valor do lance precisa ser maior que R$300.0'    
  end
end