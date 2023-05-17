require 'rails_helper'

describe 'Admin ve os lotes que passaram da data limite,' do
  
  it 'a partir do botão na tela do menu' do
    #Arrange
      user_admin = User.create!(name: "Flávio", email: "flavio@leilaodogalpao.com.br", password: "flavio_do_leilão", cpf:"50534524079")
      lot1 = Lot.create!(code: "FRA456345", start_date: Date.today, limit_date: 10.day.from_now, minimal_val: 50, minimal_difference: 10, user: user_admin)
      lot2 = Lot.create!(code: "ZFA123456", start_date: 1.day.from_now, limit_date: 15.day.from_now, minimal_val: 50, minimal_difference: 10, user: user_admin)
      
      lot3 = Lot.create!(code: "TRA456345", start_date: 1.day.from_now, limit_date: 15.day.from_now, minimal_val: 50, minimal_difference: 10, user: user_admin, status: 'aprovated')
      lot4 = Lot.create!(code: "GHZ123789", start_date: 2.day.from_now, limit_date: 10.day.from_now, minimal_val: 50, minimal_difference: 10, user: user_admin, status: 'aprovated')
    #Act
      login_as(user_admin)
      visit root_path
    #Assert             
      expect(page).to have_link "Lotes finalizados"    
  end
  
  it 'com sucesso' do
      #Arrange
        user_admin = User.create!(name: "Flávio", email: "flavio@leilaodogalpao.com.br", password: "flavio_do_leilão", cpf:"50534524079")
        Lot.create!(code: "FRA456345", start_date: 1.day.from_now, limit_date: 10.day.from_now, minimal_val: 50, minimal_difference: 10, user: user_admin)
        Lot.create!(code: "ZFA123456", start_date: 2.day.from_now, limit_date: 10.day.from_now, minimal_val: 50, minimal_difference: 10, user: user_admin)
        
        travel_to 30.day.ago do
          Lot.create!(code: "TRA456345", start_date: Date.current, limit_date: 15.day.from_now, minimal_val: 50, minimal_difference: 10, user: User.last, status: 'aprovated')
          Lot.create!(code: "GHZ123789", start_date: Date.current, limit_date: 10.day.from_now, minimal_val: 50, minimal_difference: 10, user: User.last, status: 'aprovated')
        end
      #Act
        login_as(user_admin)
        visit root_path
        click_on "Lotes finalizados"
      #Assert
        expect(current_path).to eq finished_lots_path
        expect(page).to have_content "TRA456345"      
        expect(page).to have_content "GHZ123789"               
        
        expect(page).not_to have_content "FRA456345"      
        expect(page).not_to have_content "ZFA123456"      
  end
  
  context 'com lances' do

    it 'e os detalhes' do
      #Arrange
        user_admin = User.create!(name: "Flávio", email: "flavio@leilaodogalpao.com.br", password: "flavio_do_leilão", cpf:"50534524079")
        user_admin2 = User.create!(name: "Juliana", email: "juliana@leilaodogalpao.com.br", password: "juliana_do_leilão", cpf:"36507983012")
        user_regular = User.create!(name: "José", email: "josé@gmail.com.br", password: "josésilva123", cpf:"04209958034")

        travel_to 30.day.ago do
          Lot.create!(code: "TRA456345", start_date: Date.current, limit_date: 10.day.from_now, minimal_val: 50, minimal_difference: 10, user: user_admin, status: 3)
        end

        item = Item.create!(name: 'Ninja 2000', description: 'Uma moto verde, veloz e em ótimo estado', weight: 2000, depth: 1000, height: 1500, width: 300, product_category: 'Motocicleta')
        lot_item = LotItem.create!(lot: Lot.last, item: item)
        user_bid_lot = UserBidLot.create!(lot: Lot.last, user: user_regular, bid_amount: 100)
      #Act
        login_as(user_admin2)
        visit root_path
        click_on "Lotes finalizados"
        click_on "TRA456345"
      #Assert
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
      #Arrange
        user_admin = User.create!(name: "Flávio", email: "flavio@leilaodogalpao.com.br", password: "flavio_do_leilão", cpf:"50534524079")
        user_admin2 = User.create!(name: "Juliana", email: "juliana@leilaodogalpao.com.br", password: "juliana_do_leilão", cpf:"36507983012")
        user_regular = User.create!(name: "José", email: "josé@gmail.com.br", password: "josésilva123", cpf:"04209958034")
        
        travel_to 30.day.ago do
          Lot.create!(code: "TRA456345", start_date: Date.current, limit_date: 10.day.from_now, minimal_val: 50, minimal_difference: 10, user: user_admin, status: 3)
        end

        item = Item.create!(name: 'Ninja 2000', description: 'Uma moto verde, veloz e em ótimo estado', weight: 2000, depth: 1000, height: 1500, width: 300, product_category: 'Motocicleta')
        lot_item = LotItem.create!(lot: Lot.last, item: item)
        user_bid_lot = UserBidLot.create!(lot: Lot.last, user: user_regular, bid_amount: 100)
      #Act
        login_as(user_admin2)
        visit root_path
        click_on "Lotes finalizados"
        click_on "TRA456345"
      #Assert
        expect(current_path).to eq lot_path(Lot.last.id)
        expect(page).to have_button "Encerrar lote"
        expect(page).not_to have_button "Cancelar"
    end

    it 'e encerra com sucesso' do
      #Arrange
        user_admin = User.create!(name: "Flávio", email: "flavio@leilaodogalpao.com.br", password: "flavio_do_leilão", cpf:"50534524079")
        user_admin2 = User.create!(name: "Juliana", email: "juliana@leilaodogalpao.com.br", password: "juliana_do_leilão", cpf:"36507983012")
        user_regular = User.create!(name: "José", email: "josé@gmail.com.br", password: "josésilva123", cpf:"04209958034")

        travel_to 30.day.ago do
          Lot.create!(code: "TRA456345", start_date: Date.today, limit_date: 10.day.from_now, minimal_val: 50, minimal_difference: 10, user: user_admin, status: 3)
        end

        item = Item.create!(name: 'Ninja 2000', description: 'Uma moto verde, veloz e em ótimo estado', weight: 2000, depth: 1000, height: 1500, width: 300, product_category: 'Motocicleta')
        lot_item = LotItem.create!(lot: Lot.last, item: item)
        user_bid_lot = UserBidLot.create!(lot: Lot.last, user: user_regular, bid_amount: 100)
      #Act
        login_as(user_admin2)
        visit root_path
        click_on "Lotes finalizados"
        click_on "TRA456345"
        click_on "Encerrar lote"
      #Assert
        expect(current_path).to eq lot_path(Lot.last.id)
        expect(Lot.last.status).to eq "closed"
        expect(page).to have_content "Lote encerrado com sucesso" 
        expect(page).not_to have_button "Cancelar lote" 
        expect(page).not_to have_button "Encerrar lote" 
    end
  end
  
  context 'sem lances' do

    it 'e os detalhes' do

      #Arrange
        user_admin = User.create!(name: "Flávio", email: "flavio@leilaodogalpao.com.br", password: "flavio_do_leilão", cpf:"50534524079")
        Lot.create!(code: "FRA456345", start_date: "28/05/2023", limit_date: "28/06/2023", minimal_val: 50, minimal_difference: 10, user: user_admin)
        Lot.create!(code: "ZFA123456", start_date: "24/07/2023", limit_date: "15/09/2023", minimal_val: 50, minimal_difference: 10, user: user_admin)
        
        travel_to 20.day.ago do
          Lot.create!(code: "TRA456345", start_date: Date.today, limit_date: 15.day.from_now, minimal_val: 50, minimal_difference: 10, user: user_admin, status: 'aprovated')
        end
        
        #Act
        login_as(user_admin)
        visit root_path
        click_on "Lotes finalizados"
        click_on "TRA456345"
      #Assert
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
      #Arrange
        user_admin = User.create!(name: "Flávio", email: "flavio@leilaodogalpao.com.br", password: "flavio_do_leilão", cpf:"50534524079")
        user_admin2 = User.create!(name: "Juliana", email: "juliana@leilaodogalpao.com.br", password: "juliana_do_leilão", cpf:"36507983012")
        
        travel_to 25.day.ago do
          Lot.create!(code: "GHZ123789", start_date: Date.today, limit_date: 10.day.from_now, minimal_val: 50, minimal_difference: 10, user: user_admin, status: 'aprovated')
        end
        
        item = Item.create!(name: 'Ninja 2000', description: 'Uma moto verde, veloz e em ótimo estado', weight: 2000, depth: 1000, height: 1500, width: 300, product_category: 'Motocicleta')
        lot_item = LotItem.create!(lot: Lot.last, item: item)
      
        #Act
        login_as(user_admin2)
        visit root_path
        click_on "Lotes finalizados"
        click_on "GHZ123789"
      #Assert
        expect(current_path).to eq lot_path(Lot.last.id)
        expect(page).to have_button "Cancelar lote"
        expect(page).not_to have_button "Encerrar lote"
    end

    it 'e cancela um lote com sucesso' do
      #Arrange
        user_admin = User.create!(name: "Flávio", email: "flavio@leilaodogalpao.com.br", password: "flavio_do_leilão", cpf:"50534524079")
        user_admin2 = User.create!(name: "Juliana", email: "juliana@leilaodogalpao.com.br", password: "juliana_do_leilão", cpf:"36507983012")
        
        travel_to 20.day.ago do
          Lot.create!(code: "GHZ123789", start_date: Date.today, limit_date: 10.day.from_now, minimal_val: 50, minimal_difference: 10, user: user_admin, status: 'aprovated')
        end
        
        item = Item.create!(name: 'Ninja 2000', description: 'Uma moto verde, veloz e em ótimo estado', weight: 2000, depth: 1000, height: 1500, width: 300, product_category: 'Motocicleta')
        lot_item = LotItem.create!(lot: Lot.last, item: item)
      #Act
        login_as(user_admin2)
        visit root_path
        click_on "Lotes finalizados"
        click_on "GHZ123789"
        click_on "Cancelar lote"
      #Assert
        expect(current_path).to eq lot_path(Lot.last.id)
        expect(page).to have_content "Lote cancelado com sucesso"                    
        expect(Lot.last.status).to eq "canceled"
        expect(Lot.last.lot_items).to be_empty
        expect(page).not_to have_button "Encerrar lote"      
        expect(page).not_to have_button "Cancelar lote"      
    end
    
    it 'e após cancelar um lote, os items ficam disponíveis' do
      #Arrange
        user_admin = User.create!(name: "Flávio", email: "flavio@leilaodogalpao.com.br", password: "flavio_do_leilão", cpf:"50534524079")
        travel_to 30.day.ago do
          Lot.create!(code: "GHZ123789", start_date: 4.day.from_now, limit_date: 15.day.from_now, minimal_val: 50, minimal_difference: 10, user: user_admin, status: 'aprovated')
        end
        item = Item.create!(name: 'Ninja 2000', description: 'Uma moto verde, veloz e em ótimo estado', weight: 2000, depth: 1000, height: 1500, width: 300, product_category: 'Motocicleta')
        lot_item = LotItem.create!(lot: Lot.last, item: item)
      #Act
        login_as(user_admin)
        visit root_path
        click_on "Lotes finalizados"
        click_on "GHZ123789"
        click_on "Cancelar lote"
      #Assert
        expect(Item.last.lot_item).to be_nil 
    end

  end

end