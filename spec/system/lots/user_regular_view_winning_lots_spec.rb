require 'rails_helper'

describe 'Usuário regular vê os lotes vencidos' do
  it 'a partir do link no menu' do
    #Arrange
      user_regular = User.create!(name: "Gabriel", email: "gabriel@gmail.com.br", password: "gabriel123", cpf:"04209958034")
    #Act
      login_as(user_regular)
      visit root_path
    #Assert
      expect(page).to have_link "Lotes vencidos"
  end
  it 'com sucesso' do
    #Arrange
      user_admin = User.create!(name: "Anakin", email: "anakin@leilaodogalpao.com.br", password: "anakin_do_leilão", cpf:"50534524079")
      user_admin_2 = User.create!(name: "Rogelma", email: "rogelma@leilaodogalpao.com.br", password: "rogelma_do_leilão", cpf:"36507983012")
      user_regular = User.create!(name: "Gabriel", email: "gabriel@gmail.com.br", password: "gabriel123", cpf:"04209958034")

      lot = Lot.create!(code: "TRA456345", start_date: 10.day.ago, limit_date: 5.day.ago, minimal_val: 50, minimal_difference: 10, user: user_admin, status: 3)
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

describe 'Usuário admin não ve o'