require 'rails_helper'

describe 'Usuário regular vê os lotes vencidos' do
  it 'mas precisa estar autenticado' do
    #Arrange
    
    #Act
      visit root_path
    #Assert
      expect(page).not_to have_link "Lote vencidos"
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
  
  
  
  it 'com sucesso' do
    #Arrange
      user_admin = User.create!(name: "Anakin", email: "anakin@leilaodogalpao.com.br", password: "anakin_do_leilão", cpf:"50534524079")
      user_admin_2 = User.create!(name: "Rogelma", email: "rogelma@leilaodogalpao.com.br", password: "rogelma_do_leilão", cpf:"36507983012")
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
end

