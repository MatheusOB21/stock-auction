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

  it 'caso ja seja usuário, não consegue dar lance' do
    #Arrange
      user_admin = User.create!(name: "Flávio", email: "flavio@leilaodogalpao.com.br", password: "flavio_do_leilão", cpf:"50534524079")
      user_regular = User.create!(name: "Katarina", email: "katarina@gmail.com.br", password: "katarina12345", cpf:"09036567017")
        
      item = Item.create!(name: 'Ninja 2000', description: 'Uma moto verde, veloz e em ótimo estado', weight: 2000, depth: 1000, height: 1500, width: 300, product_category: 'Motocicleta')

      lot = Lot.create!(code: "RTX306000", start_date: Date.today, limit_date: 15.day.from_now, minimal_val: 200, minimal_difference: 50, user: user_admin, status: 'aprovated')
      lot_item = LotItem.create!(lot: lot, item: item)

      Blacklist.create!(cpf: user_regular.cpf)
    
    #Act
      login_as(user_regular)
      visit root_path
      click_on 'RTX306000'
      fill_in 'Valor do lance', with: '230'
      click_on 'Dar lance'
    #Assert
      expect(current_path).to eq lot_path(lot.id)
      expect(page).to have_content 'Sua conta está suspensa, não pode dar lance!'
  end

end