require 'rails_helper'

describe 'Usuário tenta aprovar um lote,' do
  context 'mas não sendo admin' do
    
    it 'não possui acesso aos detalhes do lote' do
      #Arrange
        user_regular = User.create!(name: "Hélio", email: "hélio@leilaodohelio.com.br", password: "hélio_do_leilão", cpf:"50417550006")
        user_admin = User.create!(name: "Flávio", email: "flavio@leilaodogalpao.com.br", password: "flavio_do_leilão", cpf:"50534524079")
        lot = Lot.create!(code: "FRA456345", start_date: Date.today, limit_date: 10.day.from_now, minimal_val: 50, minimal_difference: 10, user: user_admin)
      #Act
        login_as(user_regular)
        visit lot_path(lot.id)
      #Assert
        expect(current_path).to eq root_path
        expect(page).to have_content "Você não tem acesso a essa página"      
    end
    
  end
  
  context 'sendo admin' do
    
    it 'e sendo que ele não criou, aprova com sucesso' do
      #Arrange
        user_admin = User.create!(name: "Flávio", email: "flavio@leilaodogalpao.com.br", password: "flavio_do_leilão", cpf:"50534524079")
        
        lot = Lot.create!(code: "FRA456345", start_date: Date.today, limit_date: 10.day.from_now, minimal_val: 50, minimal_difference: 10, user: user_admin)
        item = Item.create!(name: 'Ninja 2000', description: 'Uma moto verde, veloz e em ótimo estado', weight: 2000, depth: 1000, height: 1500, width: 300, product_category: 'Motocicleta')
        LotItem.create!(lot: lot, item: item)
  
        user_admin_2 = User.create!(name: "José", email: "jose@leilaodogalpao.com.br", password: "jose_do_leilão", cpf:"50417550006")
      #Act
        login_as(user_admin_2)
        visit root_path
        click_on 'Lotes pendentes'
        click_on 'FRA456345'
        click_on 'Aprovar lote'
      #Assert
        expect(current_path).to eq lot_path(lot.id)
        expect(page).to have_content "Lote aprovado com sucesso"
    end
    
    it 'aprova com sucesso, armazenando informação de quem aprovou.' do
      #Arrange
        user_admin = User.create!(name: "Flávio", email: "flavio@leilaodogalpao.com.br", password: "flavio_do_leilão", cpf:"50534524079")
        lot = Lot.create!(code: "FRA456345", start_date: Date.today, limit_date: 10.day.from_now, minimal_val: 50, minimal_difference: 10, user: user_admin)
        
        item = Item.create!(name: 'Ninja 2000', description: 'Uma moto verde, veloz e em ótimo estado', weight: 2000, depth: 1000, height: 1500, width: 300, product_category: 'Motocicleta')
        LotItem.create!(lot: lot, item: item)

        user_admin_2 = User.create!(name: "José", email: "jose@leilaodogalpao.com.br", password: "jose_do_leilão", cpf:"50417550006")
      #Act
        login_as(user_admin_2)
        visit root_path
        click_on 'Lotes pendentes'
        click_on 'FRA456345'
        click_on 'Aprovar lote'
      #Assert
        lot = Lot.last
        expect(current_path).to eq lot_path(lot.id)
        expect(lot.user_aprovated.user_id).to eq (user_admin_2.id)
        expect(page).to have_content "Lote aprovado com sucesso"
    end
    
    it 'e sendo ele que criou, não aprova' do
      #Arrange
      user_admin = User.create!(name: "Flávio", email: "flavio@leilaodogalpao.com.br", password: "flavio_do_leilão", cpf:"50534524079")
      lot = Lot.create!(code: "FLA456345", start_date: Date.today, limit_date: 10.day.from_now, minimal_val: 50, minimal_difference: 10, user: user_admin)
      item = Item.create!(name: 'Ninja 2000', description: 'Uma moto verde, veloz e em ótimo estado', weight: 2000, depth: 1000, height: 1500, width: 300, product_category: 'Motocicleta')
      
      LotItem.create!(lot: lot, item: item)
      
      #Act
        login_as(user_admin)
        visit root_path
        click_on 'Lotes pendentes'
        click_on 'FLA456345'
        click_on 'Aprovar lote'
      #Assert
        expect(current_path).to eq lot_path(lot.id)
        expect(page).to have_content "Você não pode aprovar lotes criados pelo seu usuário"
    end

    it 'caso o lote ainda não tenha itens, não aprova' do
      #Arrange
        user_admin = User.create!(name: "Flávio", email: "flavio@leilaodogalpao.com.br", password: "flavio_do_leilão", cpf:"50534524079")
        lot = Lot.create!(code: "FRA456345", start_date: Date.today, limit_date: 10.day.from_now, minimal_val: 50, minimal_difference: 10, user: user_admin)
        
        user_admin_2 = User.create!(name: "José", email: "jose@leilaodogalpao.com.br", password: "jose_do_leilão", cpf:"50417550006")
      #Act
        login_as(user_admin_2)
        visit root_path
        click_on 'Lotes pendentes'
        click_on 'FRA456345'
        click_on 'Aprovar lote'
      #Assert
      within("div.alert.alert-danger") do
        expect(page).to have_content 'Não é possível aprovar lotes sem itens adicionados'
      end 
    end
    
  end
end