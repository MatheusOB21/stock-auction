require 'rails_helper'

describe 'Usuário regular da um lance' do
  it 'a partir da tela de detalhes do lote' do
    #Arrange
      user_admin = User.create!(name: "Flávio", email: "flavio@leilaodogalpao.com.br", password: "flavio_do_leilão", cpf:"50534524079")
      user_regular = User.create!(name: "Flávio", email: "jose@gmail.com.br", password: "jose12345", cpf:"09036567017")
      
      item = Item.create!(name: 'Ninja 2000', description: 'Uma moto verde, veloz e em ótimo estado', weight: 2000, depth: 1000, height: 1500, width: 300, product_category: 'Motocicleta')

      lot = Lot.create!(code: "GTX166077", start_date: 5.day.from_now, limit_date: 15.day.from_now, minimal_val: 50, minimal_difference: 10, user: user_admin, status: 'aprovated')
      
      lot_item = LotItem.create!(lot: lot, item: item)
    #Act
      visit root_path
      click_on 'GTX166077'
    #Assert
      expect(page).to have_content "Detalhes do lote"
      expect(page).to have_content "Código"
      expect(page).to have_content "GTX166077"
      expect(page).to have_button "Dar lance"


  end
  
  it 'e esse é o primeiro do lote' do
    
  end
  it 'sem sucesso, pois informa valor inferior a diferença minima' do
    
  end
  it 'sem sucesso, pois informa valor inferior a diferença minima' do
    
  end
end