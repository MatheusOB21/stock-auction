require "rails_helper"

describe 'Usuário admin deleta item' do
    it 'com sucesso' do
    #Arrange
      user_admin = User.create!(name: "Flávio", email: "flavio@leilaodogalpao.com.br", password: "flavio_do_leilão", cpf:"50534524079")
      lot = Lot.create!(code: "FRA456345", start_date: "28/05/2023", limit_date: "28/06/2023", minimal_val: 50, minimal_difference: 10, user: user_admin)
      item = Item.create!(name: 'Ninja 2000', description: 'Uma moto verde, veloz e em ótimo estado', weight: 2000, depth: 1000, height: 1500, width: 300, product_category: 'Motocicleta')
      lot_item = LotItem.create!(lot: lot, item: item)
    #Act
      login_as(user_admin)
      visit root_path
      click_on 'Lotes pendentes'
      click_on 'FRA456345'
      click_on 'Remover item'
    #Assert
      expect(current_path).to eq lot_path(lot.id)   
      expect(page).to have_content "Item removido com sucesso"    
      expect(page).not_to have_content "Ninja 2000"    
      expect(page).not_to have_content "Uma moto verde, veloz e em ótimo estado"    
  end
end