require 'rails_helper'

describe 'Usário cadastra um novo lote' do
  context 'e sendo usuário regular' do
    it 'não vê link para cadastrar' do
      user = User.create!(name: "Hélio", email: "hélio@leilaodohelio.com.br", password: "hélio_do_leilão", cpf:"50417550006")

      login_as(user)
      visit root_path
      
      expect(page).not_to have_content "Cadastrar lote"
    end
    it 'não tem permisão para acessa a página' do
      user = User.create!(name: "Hélio", email: "hélio@leilaodohelio.com.br", password: "hélio_do_leilão", cpf:"50417550006")

      login_as(user)
      visit new_lot_path

      expect(current_path).to eq root_path
      expect(page).to have_content "Você não tem acesso a essa página"
    end
  end
  context 'e sendo usuário admin' do
      it 'possui o link para cadastrar' do
        user = User.create!(name: "Ribamar", email: "ribamar@leilaodogalpao.com.br", password: "ribamar_do_leilão", cpf:"50417550006")

        login_as(user)
        visit root_path

        expect(page).to have_content "Cadastrar lote"        
      end
      it 'tem permissão para acessa a página' do
        user = User.create!(name: "Ribamar", email: "ribamar@leilaodogalpao.com.br", password: "ribamar_do_leilão", cpf:"50417550006")

        login_as(user)
        visit new_lot_path

        expect(page).to have_content "Cadastrar novo lote"        
        expect(page).to have_field "Código"        
        expect(page).to have_field "Data início"        
        expect(page).to have_field "Data limite"        
        expect(page).to have_field "Valor mínimo de lance"        
        expect(page).to have_field "Diferença mínima de lance"        
        expect(page).to have_button "Enviar"        
      end
      it 'cadastra com sucesso' do
        user = User.create!(name: "Ribamar", email: "ribamar@leilaodogalpao.com.br", password: "ribamar_do_leilão", cpf:"50417550006")

        login_as(user)
        visit root_path
        click_on "Cadastrar lote"     
        fill_in "Código", with:  "FRA456345"      
        fill_in "Data início", with: Date.today      
        fill_in "Data limite", with: 10.day.from_now       
        fill_in "Valor mínimo de lance", with: "60"       
        fill_in "Diferença mínima de lance", with: "10"        
        click_on "Enviar"

        expect(current_path).to eq lot_path(Lot.last.id)
        expect(Lot.last.user_id).to eq user.id
        expect(page).to have_content "Lote cadastrado com sucesso"
        expect(page).to have_content "Detalhes do lote"
        expect(page).to have_content "Código FRA456345 "
        expect(page).to have_content "Data início #{I18n.l(Date.today)}"
        expect(page).to have_content "Data limite #{I18n.l(Date.current + 10.days)}"
        expect(page).to have_content "Valor mínimo de lance: 60"
        expect(page).to have_content "Diferença mínima de lance: 10"
      end
      it 'não consegue cadastrar, pois deixa um campo em branco' do
        user = User.create!(name: "Ribamar", email: "ribamar@leilaodogalpao.com.br", password: "ribamar_do_leilão", cpf:"50417550006")

        login_as(user)
        visit root_path
        click_on "Cadastrar lote"     
        fill_in "Código", with:  "FRA456345"      
        fill_in "Data início", with: ""       
        fill_in "Data limite", with: "25/06/2023"       
        fill_in "Valor mínimo de lance", with: ""       
        fill_in "Diferença mínima de lance", with: "10"        
        click_on "Enviar"

        expect(page).to have_content "Lote não cadastrado"
        expect(page).to have_content "Data início não pode ficar em branco"
        expect(page).to have_content "Valor mínimo de lance não pode ficar em branco"
      end
  end
end