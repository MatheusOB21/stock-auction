require 'rails_helper'

describe 'Usuario autenticado' do
  
  context 'e admin' do
    it 'vê as perguntas sem respostas' do
      #Arrange
        user_admin = User.create!(name: "Flávio", email: "flavio@leilaodogalpao.com.br", password: "flavio_do_leilão", cpf:"50534524079")
        user_regular = User.create!(name: "Katarina", email: "katarina@gmail.com.br", password: "katarina12345", cpf:"09036567017")
          
        item = Item.create!(name: 'Ninja 2000', description: 'Uma moto verde, veloz e em ótimo estado', weight: 2000, depth: 1000, height: 1500, width: 300, product_category: 'Motocicleta')
    
        lot = Lot.create!(code: "RTX306000", start_date: Date.today, limit_date: 15.day.from_now, minimal_val: 200, minimal_difference: 50, user: user_admin, status: 'aprovated')
        lot_item = LotItem.create!(lot: lot, item: item)
    
        question1 = Question.create!(lot: lot, question: "Qual o estado dos itens?")
        question2 = Question.create!(lot: lot, question: "Qual a procedência dos itens?")
        question3 = Question.create!(lot: lot, question: "Qual o ano da moto?")
        question4 = Question.create!(lot: lot, question: "Os items são originais?")
      
      #Act
        login_as(user_admin)
        visit root_path
        click_on 'Perguntas sem respostas'
      #Assert
        expect(current_path).to eq questions_path
        expect(page).to have_content "Qual o estado dos itens?"    
        expect(page).to have_content "Qual a procedência dos itens?"     
        expect(page).to have_content "Qual o ano da moto?"    
        expect(page).to have_content "Os items são originais?"  
    end
    
    it 'vê que não tem pergunta sem resposta' do
      #Arrange
        user_admin = User.create!(name: "Flávio", email: "flavio@leilaodogalpao.com.br", password: "flavio_do_leilão", cpf:"50534524079")
        user_regular = User.create!(name: "Katarina", email: "katarina@gmail.com.br", password: "katarina12345", cpf:"09036567017")
          
        item = Item.create!(name: 'Ninja 2000', description: 'Uma moto verde, veloz e em ótimo estado', weight: 2000, depth: 1000, height: 1500, width: 300, product_category: 'Motocicleta')
  
        lot = Lot.create!(code: "RTX306000", start_date: Date.today, limit_date: 15.day.from_now, minimal_val: 200, minimal_difference: 50, user: user_admin, status: 'aprovated')
        lot_item = LotItem.create!(lot: lot, item: item)
      #Act
        login_as(user_admin)
        visit root_path
        click_on 'Perguntas sem respostas'
      #Assert
        expect(current_path).to eq questions_path
        expect(page).to have_content "Nenhuma pergunta sem resposta"    
    end
  
    it 'responde uma pergunta com sucesso' do
      #Arrange
        user_admin = User.create!(name: "Flávio", email: "flavio@leilaodogalpao.com.br", password: "flavio_do_leilão", cpf:"50534524079")
          
        item = Item.create!(name: 'Ninja 2000', description: 'Uma moto verde, veloz e em ótimo estado', weight: 2000, depth: 1000, height: 1500, width: 300, product_category: 'Motocicleta')
    
        lot = Lot.create!(code: "RTX306000", start_date: Date.today, limit_date: 15.day.from_now, minimal_val: 200, minimal_difference: 50, user: user_admin, status: 'aprovated')
        lot_item = LotItem.create!(lot: lot, item: item)
    
        question = Question.create!(lot: lot, question: "Como funciona as regras de devolução?")
      
      #Act
        login_as(user_admin)
        visit root_path
        click_on 'Perguntas sem respostas'
        within("#1") do
          click_on 'Responder'
        end
        fill_in 'Resposta', with: 'Após a retirada, não existem devoluções de itens.'
        click_on 'Enviar'
      #Assert
        expect(current_path).to eq question_path(question.id)
        expect(page).not_to have_field "Responder"     
        expect(page).to have_content "Resposta computada com sucesso!"    
        expect(page).to have_content "Resposta"    
        expect(page).to have_content "Após a retirada, não existem devoluções de itens."    
    end
    
    it 'responde uma pergunta sem sucesso, pois deixa o campo em branco' do
      #Arrange
        user_admin = User.create!(name: "Flávio", email: "flavio@leilaodogalpao.com.br", password: "flavio_do_leilão", cpf:"50534524079")
          
        item = Item.create!(name: 'Ninja 2000', description: 'Uma moto verde, veloz e em ótimo estado', weight: 2000, depth: 1000, height: 1500, width: 300, product_category: 'Motocicleta')
    
        lot = Lot.create!(code: "RTX306000", start_date: Date.today, limit_date: 15.day.from_now, minimal_val: 200, minimal_difference: 50, user: user_admin, status: 'aprovated')
        lot_item = LotItem.create!(lot: lot, item: item)
    
        question = Question.create!(lot: lot, question: "Como funciona as regras de devolução?")
      
      #Act
        login_as(user_admin)
        visit root_path
        click_on 'Perguntas sem respostas'
        within("#1") do
          click_on 'Responder'
        end
        fill_in 'Resposta', with: ''
        click_on 'Enviar'
      #Assert
        expect(page).to have_content "Resposta não computada!"    
        expect(page).to have_content "Resposta não pode ficar em branco"    
    end

    it 'responde uma pergunta, a qual vicula ao seu usuário' do
      #Arrange
        user_admin = User.create!(name: "Flávio", email: "flavio@leilaodogalpao.com.br", password: "flavio_do_leilão", cpf:"50534524079")
          
        item = Item.create!(name: 'Ninja 2000', description: 'Uma moto verde, veloz e em ótimo estado', weight: 2000, depth: 1000, height: 1500, width: 300, product_category: 'Motocicleta')
    
        lot = Lot.create!(code: "RTX306000", start_date: Date.today, limit_date: 15.day.from_now, minimal_val: 200, minimal_difference: 50, user: user_admin, status: 'aprovated')
        lot_item = LotItem.create!(lot: lot, item: item)
    
        question = Question.create!(lot: lot, question: "Como funciona o pagamento?")
      
      #Act
        login_as(user_admin)
        visit root_path
        click_on 'Perguntas sem respostas'
        within("#1") do
          click_on 'Responder'
        end
        fill_in 'Resposta', with: 'Pagamento é feito via cartão, PIX ou em espécie'
        click_on 'Enviar'
      #Assert
        expect(Answer.last.user).to eq user_admin       
    end

  end

  context 'e regular' do
    it 'não tem acesso a página' do
      #Arrange
        user_admin = User.create!(name: "Flávio", email: "flavio@leilaodogalpao.com.br", password: "flavio_do_leilão", cpf:"50534524079")
        user_regular = User.create!(name: "Katarina", email: "katarina@gmail.com.br", password: "katarina12345", cpf:"09036567017")
          
        item = Item.create!(name: 'Ninja 2000', description: 'Uma moto verde, veloz e em ótimo estado', weight: 2000, depth: 1000, height: 1500, width: 300, product_category: 'Motocicleta')
    
        lot = Lot.create!(code: "RTX306000", start_date: Date.today, limit_date: 15.day.from_now, minimal_val: 200, minimal_difference: 50, user: user_admin, status: 'aprovated')
        lot_item = LotItem.create!(lot: lot, item: item)
    
        question1 = Question.create!(lot: lot, question: "Como funciona as regras de devolução?")
        question2 = Question.create!(lot: lot, question: "Tem garantia de fábrica?")
        question3 = Question.create!(lot: lot, question: "Posso fazer lance apenas para um item?")
        question4 = Question.create!(lot: lot, question: "Os items são originais?")
      
      #Act
        login_as(user_regular)
        visit new_question_answer_path(question1)

      #Assert
        expect(current_path).to eq root_path
        expect(page).not_to have_field "Você não tem acesso a essa página"           
    end

  end

end