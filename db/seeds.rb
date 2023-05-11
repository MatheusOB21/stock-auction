# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

#users
#admin
  user_admin = User.create!(name: "José", email: "admin@leilaodogalpao.com.br", password: "jose123456789", cpf:"50534524079")
  User.create!(name: "Leandro", email: "leandro@leilaodogalpao.com.br", password: "leandro123456789", cpf:"01699877017")
  User.create!(name: "Rose", email: "rose@leilaodogalpao.com.br", password: "rose123456789", cpf:"15041562008")
#regular
  User.create!(name: "Flávio", email: "flavio@gmail.com.br", password: "flavio123456789", cpf:"26596148068")
  User.create!(name: "Juliana", email: "juliana@gmail.com.br", password: "juliana123456789", cpf:"52575146054")
  User.create!(name: "Minato", email: "minato@gmail.com.br", password: "minato123456789", cpf:"17989653052")

#lots
  Lot.create!(code: "RTX206000", start_date: 5.day.ago, limit_date: 5.day.from_now, minimal_val: 50, minimal_difference: 10, user: user_admin)
  Lot.create!(code: "RTX207000", start_date: 10.day.from_now, limit_date: 20.day.from_now, minimal_val: 50, minimal_difference: 10, user: user_admin)
  Lot.create!(code: "RTX208000", start_date: 5.day.from_now, limit_date: 10.day.from_now, minimal_val: 50, minimal_difference: 10, user: user_admin)
  Lot.create!(code: "RTX409000", start_date: 5.day.from_now, limit_date: 10.day.from_now, minimal_val: 50, minimal_difference: 10, user: user_admin)
  Lot.create!(code: "RTX408000", start_date: 5.day.from_now, limit_date: 10.day.from_now, minimal_val: 50, minimal_difference: 10, user: user_admin)
  Lot.create!(code: "RTX407000", start_date: 10.day.ago, limit_date: 10.day.from_now, minimal_val: 50, minimal_difference: 10, user: user_admin)

#items
  Item.create!(name: 'Fazer 250', description: 'Uma moto veloz e em ótimo estado', weight: 2000, depth: 1000, height: 1500, width: 300, product_category: 'Motocicleta')
  Item.create!(name: 'Playstation 5', description: 'Um video game de altimissa qualidade', weight: 1500, depth: 300, height: 2000, width: 100, product_category: 'Video-game')
  Item.create!(name: 'Iphone X', description: 'Um ótimo celular para uso do dia a dia', weight: 1000, depth: 1000, height: 1500, width: 300, product_category: 'Celular')
  Item.create!(name: 'Carro Celta', description: 'Um ótimo carro para dirigr', weight: 200, depth: 1000, height: 1000, width: 2000, product_category: 'Carro')

#items to lot 1 e 6
  LotItem.create!(item: Item.find(1), lot: Lot.find(1))
  LotItem.create!(item: Item.find(2), lot: Lot.find(1))
  LotItem.create!(item: Item.find(3), lot: Lot.find(1))
  LotItem.create!(item: Item.find(4), lot: Lot.find(6))

#aprovando lot 1 e 6
  UserAprovated.create!(user: User.find(2), lot: Lot.find(1))
  UserAprovated.create!(user: User.find(3), lot: Lot.find(6))
