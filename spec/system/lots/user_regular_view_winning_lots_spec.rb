require 'rails_helper'

describe 'Usuário vê os lotes vencidos' do
  
  it 'mas precisa estar autenticado' do
    #Arrange
    
    #Act
      visit root_path
    #Assert
      expect(page).not_to have_link "Lote vencidos"
  end

  it 'e não estando autenticado, não tem acesso' do
    #Arrange

    #Act
      visit winners_path

    #Assert
      expect(current_path).not_to eq winners_path
      expect(current_path).to eq new_user_session_path
  end
  
  it 'a partir do link no menu' do
    #Arrange
      user_regular = User.create!(name: "Gabriel", email: "gabriel@gmail.com.br", password: "gabriel123", cpf:"04209958034")
    #Act
      login_as(user_regular)
      visit root_path
    #Assert
      expect(page).to have_link "Lotes vencidos"
  end
  
  it 'mas usuário admin não tem link no menu' do
    #Arrange
      user_admin = User.create!(name: "Luiz", email: "luiz@leilaodogalpao.com.br", password: "luiz123456", cpf:"50534524079")
    #Act
      login_as(user_admin)
      visit root_path
    #Assert
      expect(page).not_to have_link "Lotes vencidos"
  end
 
  it 'mas usuário admin não tem lotes vencidos' do
    #Arrange
      user_admin = User.create!(name: "Luiz", email: "luiz@leilaodogalpao.com.br", password: "luiz123456", cpf:"50534524079")
    #Act
      login_as(user_admin)
      visit winners_path
    #Assert
      expect(current_path).to eq root_path
      expect(page).to have_content "Usuários administradores não podem vencer lotes!"
  end
  
  it 'com sucesso' do
    #Arrange
      user_admin = User.create!(name: "Anakin", email: "anakin@leilaodogalpao.com.br", password: "anakin_do_leilão", cpf:"50534524079")
      user_regular = User.create!(name: "Gabriel", email: "gabriel@gmail.com.br", password: "gabriel123", cpf:"04209958034")
      
      travel_to 30.day.ago do
        Lot.create!(code: "TRA456345", start_date: Date.today, limit_date: 15.day.from_now, minimal_val: 50, minimal_difference: 10, user: user_admin, status: 3)
      end
      
      lot = Lot.last
      item = Item.create!(name: 'Ninja 2000', description: 'Uma moto verde, veloz e em ótimo estado', weight: 2000, depth: 1000, height: 1500, width: 300, product_category: 'Motocicleta')
      lot_item = LotItem.create!(lot: lot, item: item)
      user_bid_lot = UserBidLot.create!(lot: lot, user: user_regular, bid_amount: 200)
      lot.closed!
      lot.last_bid.won!
    #Act
      login_as(user_regular)
      visit root_path
      click_on "Lotes vencidos"
    #Assert
      expect(current_path).to eq winners_path 
      expect(page).to have_content "TRA456345" 
      expect(page).not_to have_button "Encerrar lote" 
  end
  
  it 'e os detalhes do lote que venceu' do
    #Arrange
      user_admin = User.create!(name: "Anakin", email: "anakin@leilaodogalpao.com.br", password: "anakin_do_leilão", cpf:"50534524079")
      user_regular = User.create!(name: "Gabriel", email: "gabriel@gmail.com.br", password: "gabriel123", cpf:"04209958034")
      
      travel_to 30.day.ago do
        Lot.create!(code: "TRA456345", start_date: Date.today, limit_date: 15.day.from_now, minimal_val: 50, minimal_difference: 10, user: user_admin, status: 3)
      end
      
      lot = Lot.last
      item = Item.create!(name: 'Ninja 2000', description: 'Uma moto verde, veloz e em ótimo estado', weight: 2000, depth: 1000, height: 1500, width: 300, product_category: 'Motocicleta')
      lot_item = LotItem.create!(lot: lot, item: item)
      user_bid_lot = UserBidLot.create!(lot: lot, user: user_regular, bid_amount: 200)
      lot.closed!
      lot.last_bid.won!
    #Act
      login_as(user_regular)
      visit root_path
      click_on "Lotes vencidos"
      click_on "TRA456345"
    #Assert
      expect(page).to have_content "Detalhes do lote"
      expect(page).to have_content "Código"
      expect(page).to have_content "TRA456345" 
      expect(page).to have_content "Data início"
      expect(page).to have_content "#{I18n.l(lot.start_date)}"
      expect(page).to have_content "Data limite"
      expect(page).to have_content "#{I18n.l(lot.limit_date)}"
      expect(page).to have_content "Valor mínimo de lance"
      expect(page).to have_content "50"
      expect(page).to have_content "Diferença mínima de lance"
      expect(page).to have_content "10"
      expect(page).to have_content "Items do lote"
      expect(page).to have_content "Ninja 2000"
      expect(page).to have_content "Uma moto verde, veloz e em ótimo estado"
      expect(page).to have_content "#{item.item_dimensions}"
  end
end

