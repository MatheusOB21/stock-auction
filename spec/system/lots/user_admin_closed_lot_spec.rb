require 'rails_helper'

describe 'Usuário administrador vê um lote com lances' do
  it 'e os detalhes' do
      user_admin = User.create!(name: "Flávio", email: "flavio@leilaodogalpao.com.br", password: "flavio_do_leilão", cpf:"50534524079")
      user_admin2 = User.create!(name: "Juliana", email: "juliana@leilaodogalpao.com.br", password: "juliana_do_leilão", cpf:"36507983012")
      user_regular = User.create!(name: "José", email: "josé@gmail.com.br", password: "josésilva123", cpf:"04209958034")
      travel_to 30.day.ago do
        Lot.create!(code: "TRA456345", start_date: Date.current, limit_date: 10.day.from_now, minimal_val: 50, minimal_difference: 10, user: user_admin, status: 3)
      end
      item = Item.create!(name: 'Ninja 2000', description: 'Uma moto verde, veloz e em ótimo estado', weight: 2000, depth: 1000, height: 1500, width: 300, product_category: 'Motocicleta')
      lot_item = LotItem.create!(lot: Lot.last, item: item)
      user_bid_lot = UserBidLot.create!(lot: Lot.last, user: user_regular, bid_amount: 100)

      login_as(user_admin2)
      visit root_path
      click_on "Lotes finalizados"
      click_on "TRA456345"

      expect(current_path).to eq lot_path(Lot.last.id)
      expect(page).to have_content "Código"
      expect(page).to have_content "TRA456345"   
      expect(page).to have_content "Data início"   
      expect(page).to have_content "#{I18n.l(Lot.last.start_date)}"
      expect(page).to have_content "Data limite"      
      expect(page).to have_content "#{I18n.l(Lot.last.limit_date)}"  
      expect(page).to have_content "Valor mínimo de lance"    
      expect(page).to have_content "50"
      expect(page).to have_content "Diferença mínima de lance"      
      expect(page).to have_content "10"     
      expect(page).to have_content "Lance vencendor: R$100"         
  end
  it 'e tem apenas opção para encerrar' do
      user_admin = User.create!(name: "Flávio", email: "flavio@leilaodogalpao.com.br", password: "flavio_do_leilão", cpf:"50534524079")
      user_admin2 = User.create!(name: "Juliana", email: "juliana@leilaodogalpao.com.br", password: "juliana_do_leilão", cpf:"36507983012")
      user_regular = User.create!(name: "José", email: "josé@gmail.com.br", password: "josésilva123", cpf:"04209958034")
      travel_to 30.day.ago do
        Lot.create!(code: "TRA456345", start_date: Date.current, limit_date: 10.day.from_now, minimal_val: 50, minimal_difference: 10, user: user_admin, status: 3)
      end
      item = Item.create!(name: 'Ninja 2000', description: 'Uma moto verde, veloz e em ótimo estado', weight: 2000, depth: 1000, height: 1500, width: 300, product_category: 'Motocicleta')
      lot_item = LotItem.create!(lot: Lot.last, item: item)
      user_bid_lot = UserBidLot.create!(lot: Lot.last, user: user_regular, bid_amount: 100)

      login_as(user_admin2)
      visit root_path
      click_on "Lotes finalizados"
      click_on "TRA456345"

      expect(current_path).to eq lot_path(Lot.last.id)
      expect(page).to have_button "Encerrar lote"
      expect(page).not_to have_button "Cancelar"
  end
  it 'e encerra com sucesso' do
    user_admin = User.create!(name: "Flávio", email: "flavio@leilaodogalpao.com.br", password: "flavio_do_leilão", cpf:"50534524079")
    user_admin2 = User.create!(name: "Juliana", email: "juliana@leilaodogalpao.com.br", password: "juliana_do_leilão", cpf:"36507983012")
    user_regular = User.create!(name: "José", email: "josé@gmail.com.br", password: "josésilva123", cpf:"04209958034")
    travel_to 30.day.ago do
      Lot.create!(code: "TRA456345", start_date: Date.today, limit_date: 10.day.from_now, minimal_val: 50, minimal_difference: 10, user: user_admin, status: 3)
    end
    item = Item.create!(name: 'Ninja 2000', description: 'Uma moto verde, veloz e em ótimo estado', weight: 2000, depth: 1000, height: 1500, width: 300, product_category: 'Motocicleta')
    lot_item = LotItem.create!(lot: Lot.last, item: item)
    user_bid_lot = UserBidLot.create!(lot: Lot.last, user: user_regular, bid_amount: 100)

    login_as(user_admin2)
    visit root_path
    click_on "Lotes finalizados"
    click_on "TRA456345"
    click_on "Encerrar lote"

    expect(current_path).to eq lot_path(Lot.last.id)
    expect(Lot.last.status).to eq "closed"
    expect(page).to have_content "Lote encerrado com sucesso" 
    expect(page).not_to have_button "Cancelar lote" 
    expect(page).not_to have_button "Encerrar lote" 
  end
end