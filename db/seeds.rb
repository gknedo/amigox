# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(name: "Gustavo Canedo",
             email: "gknedo@gmail.com",
             address_street: "Rua Jorge José dos Santos",
             address_number: 270,
             address_city: "Santa Rita de Caldas",
             address_state: "Minas Gerais",
             address_country: "Brasil",
             about: "O cara que quer um emprego...",
             password: "password",
             password_confirmation: "password",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

User.create!(name: "Rayane Lopes",
             email: "rayanellpz@gmail.com",
             password: "password",
             password_confirmation: "password",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

User.create!(name: "Bruno Oliveira",
             email: "kinzao_12@hotmail.com",
             password: "password",
             password_confirmation: "password",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

User.create!(name: "João Filipe Lorena",
             email: "joaofilipelorena@gmail.com",
             password: "password",
             password_confirmation: "password",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

30.times do |n|
  name = Faker::Name.name
  email = "teste#{n+4}@teste.com"
  password = "password"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end

Exchange.create(
    title: "Inauguração dos Amigos",
    description: "Descrição do primeiro amigo secreto",
    admins: [1],
    participants: [1, 2,3,4,5,6,7,8,9,10,11,12,13,14]
)

Exchange.create(
    title: "Amigo da Rayane",
    description: "Amigo da rayane",
    admins: [2],
    participants: [2]
)

Exchange.create(
    title: "Segundo Amigo da Rayane",
    description: "Descrição do amigo da rayane pronto para o sorteio",
    admins: [1,2],
    participants: [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17]
)

Exchange.create(
    title: "Amigo do Bruno",
    description: "Descrição do amigo dele",
    admins: [3],
    participants: [3]
)

Group.create(
    title: "Grupo da Capela",
    description: "Descrição do grupo da capela",
    admins: [1],
    participants: [1,2,3,4]
)