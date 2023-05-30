require 'rails_helper'

describe 'Usuário administrador vê um lote sem lances' do
  it 'e os detalhes' do
    user_admin = User.create!(name: "Flávio", email: "flavio@leilaodogalpao.com.br", password: "flavio_do_leilão", cpf:"50534524079")
    Lot.create!(code: "FRA456345", start_date: Date.today, limit_date: 15.day.from_now, minimal_val: 50, minimal_difference: 10, user: user_admin)
    Lot.create!(code: "ZFA123456", start_date: Date.today, limit_date: 15.day.from_now, minimal_val: 50, minimal_difference: 10, user: user_admin)
    travel_to 20.day.ago do
      Lot.create!(code: "TRA456345", start_date: Date.today, limit_date: 15.day.from_now, minimal_val: 50, minimal_difference: 10, user: user_admin, status: 'aprovated')
    end

    login_as(user_admin)
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
    expect(page).to have_content "Esse lote não teve lances"    
           
  end
  it 'e tem apenas opção para cancelar' do
      user_admin = User.create!(name: "Flávio", email: "flavio@leilaodogalpao.com.br", password: "flavio_do_leilão", cpf:"50534524079")
      user_admin2 = User.create!(name: "Juliana", email: "juliana@leilaodogalpao.com.br", password: "juliana_do_leilão", cpf:"36507983012")
      travel_to 25.day.ago do
        Lot.create!(code: "GHZ123789", start_date: Date.today, limit_date: 10.day.from_now, minimal_val: 50, minimal_difference: 10, user: user_admin, status: 'aprovated')
      end
      item = Item.create!(name: 'Ninja 2000', description: 'Uma moto verde, veloz e em ótimo estado', weight: 2000, depth: 1000, height: 1500, width: 300, product_category: 'Motocicleta')
      lot_item = LotItem.create!(lot: Lot.last, item: item)

      login_as(user_admin2)
      visit root_path
      click_on "Lotes finalizados"
      click_on "GHZ123789"

      expect(current_path).to eq lot_path(Lot.last.id)
      expect(page).to have_button "Cancelar lote"
      expect(page).not_to have_button "Encerrar lote"
  end
  it 'e cancela com sucesso' do
      user_admin = User.create!(name: "Flávio", email: "flavio@leilaodogalpao.com.br", password: "flavio_do_leilão", cpf:"50534524079")
      user_admin2 = User.create!(name: "Juliana", email: "juliana@leilaodogalpao.com.br", password: "juliana_do_leilão", cpf:"36507983012")
      travel_to 20.day.ago do
        Lot.create!(code: "GHZ123789", start_date: Date.today, limit_date: 10.day.from_now, minimal_val: 50, minimal_difference: 10, user: user_admin, status: 'aprovated')
      end
      item = Item.create!(name: 'Ninja 2000', description: 'Uma moto verde, veloz e em ótimo estado', weight: 2000, depth: 1000, height: 1500, width: 300, product_category: 'Motocicleta')
      lot_item = LotItem.create!(lot: Lot.last, item: item)

      login_as(user_admin2)
      visit root_path
      click_on "Lotes finalizados"
      click_on "GHZ123789"
      click_on "Cancelar lote"

      expect(current_path).to eq lot_path(Lot.last.id)
      expect(page).to have_content "Lote cancelado com sucesso"                    
      expect(Lot.last.status).to eq "canceled"
      expect(Lot.last.lot_items).to be_empty
      expect(page).not_to have_button "Encerrar lote"      
      expect(page).not_to have_button "Cancelar lote"      
  end
  it 'e após cancelar, os items ficam disponíveis' do
    user_admin = User.create!(name: "Flávio", email: "flavio@leilaodogalpao.com.br", password: "flavio_do_leilão", cpf:"50534524079")
    travel_to 30.day.ago do
      Lot.create!(code: "GHZ123789", start_date: 4.day.from_now, limit_date: 15.day.from_now, minimal_val: 50, minimal_difference: 10, user: user_admin, status: 'aprovated')
    end
    item = Item.create!(name: 'Ninja 2000', description: 'Uma moto verde, veloz e em ótimo estado', weight: 2000, depth: 1000, height: 1500, width: 300, product_category: 'Motocicleta')
    lot_item = LotItem.create!(lot: Lot.last, item: item)

    login_as(user_admin)
    visit root_path
    click_on "Lotes finalizados"
    click_on "GHZ123789"
    click_on "Cancelar lote"

    expect(Item.last.lot_item).to be_nil 
  end
end