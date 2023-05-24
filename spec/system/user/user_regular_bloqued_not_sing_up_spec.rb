require 'rails_helper' 

describe 'Um CPF que está na lista de bloqueio' do
  
  it 'não consegue criar conta' do
    user_admin = User.create!(name: "Paulo", email: "paulo@leilaodogalpao.com.br", cpf: '41505837065', password: 'paulo123456789')
    user = User.create!(name: "Laura", email: "laura@gmail.com", cpf: '90347825060', password: 'laura123456789')
    Blacklist.create!(cpf: "39588266017")
    
    visit root_path
    click_on 'Login'
    click_on 'Criar conta'
    fill_in 'Nome', with: 'João'
    fill_in 'CPF', with: '39588266017'
    fill_in 'E-mail', with: 'joão@gmail.com.br'
    fill_in 'Senha', with: 'joao@1234'
    fill_in 'Confirme sua senha', with: 'joao@1234'
    click_on 'Criar conta'

    expect(page).to have_content 'CPF bloqueado pela administração. Não pode criar conta!'
  end

  it 'caso ja seja usuário, é avisado da suspensão da conta' do
    user = User.create!(name: "Laura", email: "laura@gmail.com", cpf: '90347825060', password: 'laura123456789')
    Blacklist.create!(cpf: user.cpf)

    visit root_path
    within('nav') do
      click_on 'Login'
    end
    fill_in 'E-mail', with: 'laura@gmail.com'
    fill_in 'Senha', with: 'laura123456789'
    within('#form-login') do
      click_on 'Login'  
    end

    expect(page).to have_content 'Sua conta foi suspensa pela administração'
    
  end

end