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

Exchange.create(
    title: "Inauguração dos Amigos",
    description: "Primeiro amigo secreto =D",
    admins: [1],
    participants: [1, 2, 3, 4]
)

Group.create(
    title: "Grupo de Santa Rita",
    description: "Para os amigos do arraiá",
    admins: [1],
    participants: [1, 2, 3, 4]
)