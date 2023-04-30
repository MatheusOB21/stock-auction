require 'rails_helper'

describe 'Usuário registra nova conta' do
  it 'a partir da tela sing up' do
    #Arrange

    #Act
      visit root_path
      click_on 'Criar conta'
    #Assert
      expect(current_path).to eq new_user_registration_path
      expect(page).to have_content 'Nome'
      expect(page).to have_content 'CPF'
      expect(page).to have_content 'E-mail'
      expect(page).to have_content 'Senha'
  end

  context 'admin' do
    it 'com sucesso' do
      #Arrange

      #Act
        visit root_path
        click_on 'Criar conta'
        fill_in 'Nome', with: 'José'
        fill_in 'CPF', with: '39551824016'
        fill_in 'E-mail', with: 'jose@leilaodogalpao.com.br'
        fill_in 'Senha', with: 'admin@1234'
        fill_in 'Confirme sua senha', with: 'admin@1234'
        click_on 'Criar conta'
      #Assert
        expect(page).to have_content 'Bem vindo! Você realizou seu registro com sucesso.'
        expect(page).to have_content 'José'
        expect(page).to have_button 'Sair'
        user = User.last 
        expect(user.email).to eq 'jose@leilaodogalpao.com.br'
    end
  end
end