require 'rails_helper'

describe 'Usuario regular' do
  context 'não autenticado' do
    it 'visualiza os detalhes de um lote e seus itens' do
      user_admin = User.create!(name: "Flávio", email: "flavio@leilaodogalpao.com.br", password: "flavio_do_leilão", cpf:"50534524079")
      item = Item.create!(name: 'Ninja 2000', description: 'Uma moto verde, veloz e em ótimo estado', weight: 2000, depth: 1000, height: 1500, width: 300, product_category: 'Motocicleta')
      lot1 = Lot.create!(code: "ZTZ456789", start_date: Date.today, limit_date: 10.day.from_now, minimal_val: 50, minimal_difference: 10, user: user_admin, status: 'aprovated')
      lot2 = Lot.create!(code: "GTX166077", start_date: 5.day.from_now, limit_date: 15.day.from_now, minimal_val: 50, minimal_difference: 10, user: user_admin, status: 'aprovated')
      lot_item = LotItem.create!(lot: lot2, item: item)
      
      visit root_path
      click_on 'GTX166077'
      
      expect(page).to have_content "Detalhes do lote"
      expect(page).to have_content "Código"
      expect(page).to have_content "GTX166077"
      expect(page).to have_content "Data início"
      expect(page).to have_content "#{I18n.l(lot2.start_date)}"
      expect(page).to have_content "Data limite"
      expect(page).to have_content "#{I18n.l(lot2.limit_date)}"
      expect(page).to have_content "Valor mínimo de lance"
      expect(page).to have_content "50"
      expect(page).to have_content "Diferença mínima de lance"
      expect(page).to have_content "10"
      expect(page).to have_content "Items do lote"
      expect(page).to have_content "Ninja 2000"
      expect(page).to have_content "Uma moto verde, veloz e em ótimo estado"
      expect(page).to have_content "#{item.item_dimensions}"
      expect(page).not_to have_content "FRA456345"
    end 
    it 'não consegue visualizar detalhes de lotes pendentes' do
      user_admin = User.create!(name: "Flávio", email: "flavio@leilaodogalpao.com.br", password: "flavio_do_leilão", cpf:"50534524079")
      item = Item.create!(name: 'Ninja 2000', description: 'Uma moto verde, veloz e em ótimo estado', weight: 2000, depth: 1000, height: 1500, width: 300, product_category: 'Motocicleta')
      lot = Lot.create!(code: "ZTZ456789", start_date: 1.day.from_now, limit_date: 10.day.from_now, minimal_val: 50, minimal_difference: 10, user: user_admin, status: 'pending')
      lot_item = LotItem.create!(lot: lot, item: item)

      visit lot_path(lot.id)

      expect(current_path).not_to eq lot_path(lot.id)
      expect(page).to have_content "Você não tem acesso a essa página"
    end
  end
  context 'autenticado' do
    it 'visualiza os detalhes de um lote e seus itens' do
      user_admin = User.create!(name: "Flávio", email: "flavio@leilaodogalpao.com.br", password: "flavio_do_leilão", cpf:"50534524079")
      user_regular = User.create!(name: "Natália", email: "natalia@gmail.com.br", password: "natalia_do_leilão", cpf:"39451000038")
      item = Item.create!(name: 'Ninja 2000', description: 'Uma moto verde, veloz e em ótimo estado', weight: 2000, depth: 1000, height: 1500, width: 300, product_category: 'Motocicleta')
      lot1 = Lot.create!(code: "ZTZ456789", start_date: Date.today, limit_date: 15.day.from_now, minimal_val: 50, minimal_difference: 10, user: user_admin, status: 'aprovated')
      lot2 = Lot.create!(code: "GTX166077", start_date: 5.day.from_now, limit_date: 15.day.from_now, minimal_val: 50, minimal_difference: 10, user: user_admin, status: 'aprovated')
      lot_item = LotItem.create!(lot: lot2, item: item)

      login_as(user_regular)
      visit root_path
      click_on 'GTX166077'

      expect(page).to have_content "Detalhes do lote"
      expect(page).to have_content "Código"
      expect(page).to have_content "GTX166077"
      expect(page).to have_content "Data início"
      expect(page).to have_content "#{I18n.l(lot2.start_date)}"
      expect(page).to have_content "Data limite"
      expect(page).to have_content "#{I18n.l(lot2.limit_date)}"
      expect(page).to have_content "Valor mínimo de lance"
      expect(page).to have_content "50"
      expect(page).to have_content "Diferença mínima de lance"
      expect(page).to have_content "10"
      expect(page).to have_content "Items do lote"
      expect(page).to have_content "Ninja 2000"
      expect(page).to have_content "Uma moto verde, veloz e em ótimo estado"
      expect(page).to have_content "#{item.item_dimensions}"
      expect(page).not_to have_content "FRA456345"
    end  
    it 'não consegue visualizar detalhes de lotes pendentes' do
      user_admin = User.create!(name: "Flávio", email: "flavio@leilaodogalpao.com.br", password: "flavio_do_leilão", cpf:"50534524079")
      user_regular = User.create!(name: "Natália", email: "natalia@gmail.com.br", password: "natalia_do_leilão", cpf:"39451000038")
      item = Item.create!(name: 'Ninja 2000', description: 'Uma moto verde, veloz e em ótimo estado', weight: 2000, depth: 1000, height: 1500, width: 300, product_category: 'Motocicleta')
      lot = Lot.create!(code: "ZTZ456789", start_date: Date.today, limit_date: 15.day.from_now, minimal_val: 50, minimal_difference: 10, user: user_admin, status: 'pending')
      lot_item = LotItem.create!(lot: lot, item: item)

      login_as(user_regular)
      visit lot_path(lot.id)

      expect(current_path).not_to eq lot_path(lot.id)
      expect(page).to have_content "Você não tem acesso a essa página"
    end
  end
end