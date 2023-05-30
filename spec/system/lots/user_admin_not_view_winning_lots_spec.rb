require 'rails_helper'

describe 'Usuário admininistrador não vê lotes vencidos, pois' do
  it 'não tem link no menu' do
      user_admin = User.create!(name: "Luiz", email: "luiz@leilaodogalpao.com.br", password: "luiz123456", cpf:"50534524079")

      login_as(user_admin)
      visit root_path

      expect(page).not_to have_link "Lotes vencidos"
  end
  it 'não tem acesso a página lotes vencidos' do
      user_admin = User.create!(name: "Luiz", email: "luiz@leilaodogalpao.com.br", password: "luiz123456", cpf:"50534524079")

      login_as(user_admin)
      visit winners_path

      expect(current_path).to eq root_path
      expect(page).to have_content "Usuários administradores não podem vencer lotes!"
  end
end