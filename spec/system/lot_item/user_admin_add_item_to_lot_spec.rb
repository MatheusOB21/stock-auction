require "rails_helper"

describe 'Usuário admin adiciona item' do
  
  it 'ao lote com sucesso' do
      user_admin = User.create!(name: "Flávio", email: "flavio@leilaodogalpao.com.br", password: "flavio_do_leilão", cpf:"50534524079")
      lot = Lot.create!(code: "FRA456345", start_date: Date.today, limit_date: 10.day.from_now, minimal_val: 50, minimal_difference: 10, user: user_admin)
      allow(SecureRandom).to receive(:alphanumeric).with(10).and_return("NINJA12345")
      item = Item.create!(name: 'Ninja 2000', description: 'Uma moto verde, veloz e em ótimo estado', weight: 2000, depth: 1000, height: 1500, width: 300, product_category: 'Motocicleta')
    
      login_as(user_admin)
      visit root_path
      click_on 'Lotes pendentes'
      click_on 'FRA456345'
      click_on 'Adicionar item'
      select 'Ninja 2000', from: 'Itens'
      click_on 'Enviar'

      expect(item.code).to eq "NINJA12345"
      expect(current_path).to eq lot_path(lot.id)
      expect(page).to have_content "Item adicionado com sucesso"    
      expect(page).to have_content "Items do lote:"    
      expect(page).to have_content "Ninja 2000"    
      expect(page).to have_content "Uma moto verde, veloz e em ótimo estado"    
      expect(page).to have_content "#{item.item_dimensions}"    
  end
  
  it 'que não estão em outros lotes' do
      user_admin = User.create!(name: "Flávio", email: "flavio@leilaodogalpao.com.br", password: "flavio_do_leilão", cpf:"50534524079")
      lot1 = Lot.create!(code: "FRA456345", start_date: Date.today, limit_date: 10.day.from_now, minimal_val: 50, minimal_difference: 10, user: user_admin)
      lot2 = Lot.create!(code: "FRA123456", start_date: Date.today, limit_date: 10.day.from_now, minimal_val: 50, minimal_difference: 10, user: user_admin)
      item1 = Item.create!(name: 'Ninja 2000', description: 'Uma moto verde, veloz e em ótimo estado', weight: 2000, depth: 1000, height: 1500, width: 300, product_category: 'Motocicleta')
      item2 = Item.create!(name: 'Ninja 1500', description: 'Uma moto azul, veloz e em ótimo estado', weight: 2000, depth: 1000, height: 1500, width: 300, product_category: 'Motocicleta')
      item3 = Item.create!(name: 'Ninja 1000', description: 'Uma moto amarela, veloz e em ótimo estado', weight: 2000, depth: 1000, height: 1500, width: 300, product_category: 'Motocicleta')
      LotItem.create!(lot: lot1, item: item1)
      LotItem.create!(lot: lot1, item: item2)

      login_as(user_admin)
      visit root_path
      click_on 'Lotes pendentes'
      click_on 'FRA123456'
      click_on 'Adicionar item'

      expect(page).to have_content "Ninja 1000"    
      expect(page).not_to have_content "Ninja 2000"    
      expect(page).not_to have_content "Ninja 1500"    
  end
  
  it 'apenas a lotes pendentes' do
      user_admin = User.create!(name: "Flávio", email: "flavio@leilaodogalpao.com.br", password: "flavio_do_leilão", cpf:"50534524079")
      user_admin_2 = User.create!(name: "Mario", email: "mario@leilaodogalpao.com.br", password: "mario_do_leilão", cpf:"74574823003")
      lot = Lot.create!(code: "FRA456345", start_date: Date.today, limit_date: 10.day.from_now, minimal_val: 50, minimal_difference: 10, user: user_admin)
      item = Item.create!(name: 'Ninja 2000', description: 'Uma moto verde, veloz e em ótimo estado', weight: 2000, depth: 1000, height: 1500, width: 300, product_category: 'Motocicleta')
      LotItem.create!(lot: lot, item: item)

      login_as(user_admin_2)
      visit root_path
      click_on 'Lotes pendentes'
      click_on 'FRA456345'
      click_on 'Aprovar lote'

      expect(page).not_to have_button "Adicionar item"    
      expect(page).not_to have_button "Remover item"    
  end

end