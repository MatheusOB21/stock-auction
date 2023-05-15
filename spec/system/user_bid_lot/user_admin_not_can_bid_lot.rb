require 'rails_helper'

describe 'Usuário admin' do
  it 'não pode dar um lance' do
    #Arrange
      user_admin = User.create!(name: "Leandro", email: "leandro@leilaodogalpao.com.br", password: "leandro123", cpf: "63254697049")
      
      item = Item.create!(name: 'Ninja 2000', description: 'Uma moto verde, veloz e em ótimo estado', weight: 2000, depth: 1000, height: 1500, width: 300, product_category: 'Motocicleta')
      lot = Lot.create!(code: "RTX306000", start_date: 5.day.ago, limit_date: 10.day.from_now, minimal_val: 200, minimal_difference: 50, user: user_admin, status: 'aprovated')
      lot_item = LotItem.create!(lot: lot, item: item)
    
    #Act
      login_as(user_admin)
      visit root_path
      click_on 'RTX306000'
      fill_in 'Valor do lance', with: '250'
      click_on 'Dar lance'
    #Assert
      expect(Lot.last.user_bid_lot.bid_amount).not_to eq 250
      expect(page).to have_content "Administradores não podem dar lance!"
  end
end