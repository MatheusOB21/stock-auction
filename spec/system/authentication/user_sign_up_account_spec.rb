require 'rails_helper'

describe 'Usuário registra conta' do
  it 'a partir da tela sing up' do
      visit root_path
      click_on 'Login'
      click_on 'Criar conta'

      expect(current_path).to eq new_user_registration_path
      expect(page).to have_content 'Nome'
      expect(page).to have_content 'CPF'
      expect(page).to have_content 'E-mail'
      expect(page).to have_content 'Senha'
  end

  context 'regular' do
    it 'com sucesso' do
        visit root_path
        click_on 'Login'
        click_on 'Criar conta'
        fill_in 'Nome', with: 'José'
        fill_in 'CPF', with: '39588266017'
        fill_in 'E-mail', with: 'jose@gmail.com.br'
        fill_in 'Senha', with: 'jose@1234'
        fill_in 'Confirme sua senha', with: 'jose@1234'
        click_on 'Criar conta'

        expect(page).to have_content 'Bem vindo! Você realizou seu registro com sucesso.'
        expect(page).to have_content 'José'
        expect(page).to have_button 'Sair'
        user = User.last 
        expect(user.email).to eq 'jose@gmail.com.br'
    end
    it 'sem sucesso' do
      visit root_path
      click_on 'Login'
      click_on 'Criar conta'
      fill_in 'Nome', with: 'Maria'
      fill_in 'CPF', with: '123456789102'
      fill_in 'E-mail', with: 'maria@gmail.com.br'
      fill_in 'Senha', with: 'maria@12345'
      fill_in 'Confirme sua senha', with: 'maria12345'
      click_on 'Criar conta'

      expect(current_path).not_to eq root_path
      expect(page).to have_content 'CPF é inválido'
      expect(User.all.empty?).to eq true
    end
  end

  context 'admin' do
    it 'sem sucesso' do
      visit root_path
      click_on 'Login'
      click_on 'Criar conta'
      fill_in 'Nome', with: 'Maria'
      fill_in 'CPF', with: '123456789102'
      fill_in 'E-mail', with: 'maria@leilaodogalpao.com.br'
      fill_in 'Senha', with: 'admin@12345'
      fill_in 'Confirme sua senha', with: 'admin@12345'
      click_on 'Criar conta'

      expect(current_path).not_to eq root_path
      expect(page).to have_content 'CPF é inválido'
      expect(User.all.empty?).to eq true
    end
    it 'com sucesso' do
      visit root_path
      click_on 'Login'
      click_on 'Criar conta'
      fill_in 'Nome', with: 'Julia'
      fill_in 'CPF', with: '11665475315'
      fill_in 'E-mail', with: 'julia@leilaodogalpao.com.br'
      fill_in 'Senha', with: 'admin@admin'
      fill_in 'Confirme sua senha', with: 'admin@admin'
      click_on 'Criar conta'

      expect(page).to have_content 'Admin: Julia'
      expect(page).to have_content 'Bem vindo! Você realizou seu registro com sucesso.'
      expect(User.last.name).to eq 'Julia'
      expect(User.last.is_admin).to eq true
    end
  end
end