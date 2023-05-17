# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


#users
#admin
  user_admin = User.create!(name: "José", email: "jose@leilaodogalpao.com.br", password: "jose123456789", cpf:"50534524079")
  User.create!(name: "Leandro", email: "leandro@leilaodogalpao.com.br", password: "leandro123456789", cpf:"01699877017")
  User.create!(name: "Rose", email: "rose@leilaodogalpao.com.br", password: "rose123456789", cpf:"15041562008")
#regular
  flavio = User.create!(name: "Flávio", email: "flavio@gmail.com.br", password: "flavio123456789", cpf:"26596148068")
  juliana = User.create!(name: "Juliana", email: "juliana@gmail.com.br", password: "juliana123456789", cpf:"52575146054")
  marcos = User.create!(name: "Marcos", email: "marcos@gmail.com.br", password: "marcos123456789", cpf:"17989653052")

#lots

  #lots em andamento
    Lot.create!(code: "QWE407000", start_date: Date.today, limit_date: 10.day.from_now, minimal_val: 50, minimal_difference: 10, user: user_admin, status: "aprovated")
    Lot.create!(code: "UPR407000", start_date: Date.today, limit_date: 10.day.from_now, minimal_val: 50, minimal_difference: 10, user: user_admin, status: "aprovated")
    Lot.create!(code: "VAL407000", start_date: Date.today, limit_date: 10.day.from_now, minimal_val: 50, minimal_difference: 10, user: user_admin, status: "aprovated")

  #lots finalizados
    lot1 = Lot.new(code: "MAN407000", start_date: 10.day.ago, limit_date: 9.day.ago, minimal_val: 50, minimal_difference: 10, user: user_admin, status: "aprovated")
    lot1.save(:validate => false)

    lot2 = Lot.new(code: "FRA407000", start_date: 10.day.ago, limit_date: 8.day.ago, minimal_val: 50, minimal_difference: 10, user: user_admin, status: "aprovated")
    lot2.save(:validate => false)
    
    lot3 = Lot.new(code: "GTX206000", start_date: 10.day.ago, limit_date: 7.day.ago, minimal_val: 50, minimal_difference: 10, user: user_admin, status: "aprovated")
    lot3.save(:validate => false)

  #lots futuro e pendentes para aprovação
  Lot.create!(code: "ZXC207000", start_date: 10.day.from_now, limit_date: 20.day.from_now, minimal_val: 50, minimal_difference: 10, user: user_admin)
  Lot.create!(code: "CFV208000", start_date: 5.day.from_now, limit_date: 10.day.from_now, minimal_val: 50, minimal_difference: 10, user: user_admin)
  Lot.create!(code: "ATR409000", start_date: 5.day.from_now, limit_date: 10.day.from_now, minimal_val: 50, minimal_difference: 10, user: user_admin)
  Lot.create!(code: "YZT408000", start_date: 5.day.from_now, limit_date: 10.day.from_now, minimal_val: 50, minimal_difference: 10, user: user_admin)
  
#items
  item1 = Item.create!(name: 'Fazer 250', description: 'Uma moto veloz e em ótimo estado', weight: 2000, depth: 1000, height: 1500, width: 300, product_category: 'Motocicleta')
  item1.image.attach(io: File.open("#{Rails.root}/app/assets/images/moto.jpg"), filename: 'moto.jpg', content_type: 'image/jpg')
  
  item2 =Item.create!(name: 'Fazer 350', description: 'Uma moto veloz e em ótimo estado', weight: 2000, depth: 1000, height: 1500, width: 300, product_category: 'Motocicleta')

  item3 = Item.create!(name: 'Playstation 5', description: 'Um video game de altimissa qualidade', weight: 1500, depth: 300, height: 2000, width: 100, product_category: 'Video-game')
  item3.image.attach(io: File.open("#{Rails.root}/app/assets/images/playstation.jpg"), filename: 'playstation.jpg', content_type: 'image/jpg')

  item4 = Item.create!(name: 'Iphone X', description: 'Um ótimo celular para uso do dia a dia', weight: 1000, depth: 1000, height: 1500, width: 300, product_category: 'Celular')

  item5 = Item.create!(name: 'Carro Celta', description: 'Um ótimo carro para dirigir', weight: 200, depth: 1000, height: 1000, width: 2000, product_category: 'Carro')
  item5.image.attach(io: File.open("#{Rails.root}/app/assets/images/carro.jpg"), filename: 'carro.jpg', content_type: 'image/jpg')
  
  item6 = Item.create!(name: 'Carro Palio', description: 'Um ótimo carro para dirigir', weight: 200, depth: 1000, height: 1000, width: 2000, product_category: 'Carro')

#items to lot 1, 2, 3, 4, 5 e 6
  LotItem.create!(item: Item.find(1), lot: Lot.find(1))
  LotItem.create!(item: Item.find(2), lot: Lot.find(2))
  LotItem.create!(item: Item.find(3), lot: Lot.find(3))
  LotItem.create!(item: Item.find(4), lot: Lot.find(4))
  LotItem.create!(item: Item.find(5), lot: Lot.find(5))
  LotItem.create!(item: Item.find(6), lot: Lot.find(6))

#aprovando lot 1, 3, 4 e 5
  UserAprovated.create!(user: User.find(2), lot: Lot.find(1))
  UserAprovated.create!(user: User.find(3), lot: Lot.find(2))
  UserAprovated.create!(user: User.find(3), lot: Lot.find(3))
  UserAprovated.create!(user: User.find(3), lot: Lot.find(4))

#usuario regular Flavio vai da o unico lance pelo lot
UserBidLot.create!(user:flavio, lot: lot1, bid_amount: 500)

#usuario regular Juliana vai da o unico lance pelo lot
UserBidLot.create!(user:flavio, lot: Lot.find(1), bid_amount: 1000)

#usuarios fazem perguntas sobre o lot
Question.create!(lot: Lot.find(1), question: "Como funciona a forma de pagamento?")
Question.create!(lot: Lot.find(2), question: "Qual a validade dos itens?")
Question.create!(lot: Lot.find(2), question: "Como posso fazer para retirar os itens?")
Question.create!(lot: Lot.find(3), question: "Existe algum certificado de garantia?")

#usuario admin responde algumas perguntas
Answer.create!(question: Question.find(1), user: user_admin, answer: "Pode ser pago por dinheiro ou cartão")
Answer.create!(question: Question.find(2), user: user_admin, answer: "Todos os itens são válidos!")
Answer.create!(question: Question.find(3), user: user_admin, answer: "Bem simples, pode ir em um de nossos galpões mais próximo, ou podemos enviar pelos correios.")
