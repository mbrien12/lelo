require 'faker'

puts 'Cleaning database...'
Skill.destroy_all
User.destroy_all



puts "Creating 2 teachers with 1 skill each"

  teacher1 = User.create(
    email: "teacher1@teacher1.com",
    password: Faker::Internet.password,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    location: "Nex, Gloria, Rio",
    latitude: 22.92084,
    longitude: -43.17809,
    photo: "https://assets.entrepreneur.com/content/3x2/1300/20150406145944-dos-donts-taking-perfect-linkedin-profile-picture-selfie-mobile-camera-2.jpeg",
    role: "teacher",
    bio: "Hello I'm a teacher"
    )

  teacher1.skills.create(
    name: "Ruby",
    description: "I can teach you how to create a Ruby on Rails application",
    price: 10,
    category: "Programming"
    )

  teacher2 = User.create(
    email: "teacher2@teacher2.com",
    password: Faker::Internet.password,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    location: "Copacabana beach, Rio",
    latitude: 22.96944,
    longitude: 43.1822416,
    photo: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSJFRuAejYIvKte1YL7eTyYc-szQKEDtOTtQlPOPWs6QtkHy3T_eg",
    role: "teacher",
    bio: "Hello I'm another teacher"
    )

   teacher2.skills.create(
    name: "Guitar lessons",
    description: "I'm a professional guitar player, come jam with me to improve your skills!",
    price: 8,
    category: "Music"
    )



