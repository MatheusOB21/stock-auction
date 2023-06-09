require "rails_helper"

describe 'Usuário admin remove item' do
  it 'com sucesso' do
      user_admin = User.create!(name: "Flávio", email: "flavio@leilaodogalpao.com.br", password: "flavio_do_leilão", cpf:"50534524079")
      lot = Lot.create!(code: "FRA456345", start_date: Date.today, limit_date: 10.day.from_now, minimal_val: 50, minimal_difference: 10, user: user_admin)
      item = Item.create!(name: 'Ninja 2000', description: 'Uma moto verde, veloz e em ótimo estado', weight: 2000, depth: 1000, height: 1500, width: 300, product_category: 'Motocicleta')
      lot_item = LotItem.create!(lot: lot, item: item)

      login_as(user_admin)
      visit root_path
      click_on 'Lotes pendentes'
      click_on 'FRA456345'
      click_on 'Remover item'

      expect(current_path).to eq lot_path(lot.id)   
      expect(page).to have_content "Item removido com sucesso"    
      expect(page).not_to have_content "Ninja 2000"    
      expect(page).not_to have_content "Uma moto verde, veloz e em ótimo estado"    
  end
  it 'apenas de lote com status pendente' do
      user_admin = User.create!(name: "Flávio", email: "flavio@leilaodogalpao.com.br", password: "flavio_do_leilão", cpf:"50534524079")
      user_admin_2 = User.create!(name: "Luiz", email: "luiz@leilaodogalpao.com.br", password: "luiz_do_leilão", cpf:"40311733000")
      lot = Lot.create!(code: "FRA456345", start_date: Date.today, limit_date: 10.day.from_now, minimal_val: 50, minimal_difference: 10, user: user_admin)
      item = Item.create!(name: 'Ninja 2000', description: 'Uma moto verde, veloz e em ótimo estado', weight: 2000, depth: 1000, height: 1500, width: 300, product_category: 'Motocicleta')  
      lot_item = LotItem.create!(lot: lot, item: item)

      login_as(user_admin_2)
      visit root_path
      click_on 'Lotes pendentes'
      click_on 'FRA456345'
      click_on 'Aprovar lote'

      expect(page).not_to have_content "Remover item"     
  end
  it 'e fica disponível para adicionar em outro lote' do
      user_admin = User.create!(name: "Flávio", email: "flavio@leilaodogalpao.com.br", password: "flavio_do_leilão", cpf:"50534524079")
      user_admin_2 = User.create!(name: "Luiz", email: "luiz@leilaodogalpao.com.br", password: "luiz_do_leilão", cpf:"40311733000")
      lot = Lot.create!(code: "FRA456345", start_date: Date.today, limit_date: 10.day.from_now, minimal_val: 50, minimal_difference: 10, user: user_admin)
      item = Item.create!(name: 'Ninja 2000', description: 'Uma moto verde, veloz e em ótimo estado', weight: 2000, depth: 1000, height: 1500, width: 300, product_category: 'Motocicleta')
      lot_item = LotItem.create!(lot: lot, item: item)

      login_as(user_admin_2)
      visit root_path
      click_on 'Lotes pendentes'
      click_on 'FRA456345'
      click_on 'Remover item'

      expect(page).to have_content "Item removido com sucesso"
      expect(LotItem.last).to be nil  
  end
end