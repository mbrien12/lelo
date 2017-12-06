require 'faker'

puts 'Cleaning database...'
Review.destroy_all
puts 'Reviews Cleaned'
Message.destroy_all
puts 'Messages Cleaned'
Lesson.destroy_all
puts 'Lessons Cleaned'
Skill.destroy_all
puts 'Skills Cleaned'
User.delete_all
puts 'Users Cleaned'



opened = open("db/google_addresses.json")
puts 'opened'
read = opened.read
puts 'read'
googleAddresses = JSON.parse(read)
puts 'parsed addresses'
teachers = JSON.parse(open("db/random_teachers.json").read)['results']
puts 'parsed teachers'
photos = JSON.parse(open('db/uploaded_pics.json').read)


googleAddresses.each_with_index do |address,i|
  teacher = teachers[i]
  t = User.new(
    email: teacher['email'],
    password: '123456',
    first_name: teacher['name']['first'],
    last_name: teacher['name']['last'],
    role: 'teacher')
  t.save
  t.update_columns(photo: photos[i])

  skill_type = [0,1,2,3].sample
  skill_availability = ["Mon-Fri 8am to 12pm","Mon-Fri after 7pm", "Fri-Sun 8am to 6pm", "Mondays and Tuesdays after 6pm", "Wednesdays and Fridays all day","Weekdays only","Weekends only"].sample

  case skill_type
  when 0
    skill_name = ["FORTRAN", "ALGOL", "Newspeak", "D", "Prolog", "Simula", "JavaScript", "Java", "C#", "Clojure", "COBOL", "Lua", "Smalltalk", "Swift", "Ruby", "Lisp", "Scala", "C", "Python", "Scheme", "Fortress", "C++", "Go", "Perl", "Haskell", "Delphi"].sample
    skill_description = "Learn how to code in #{skill_name}!"
    skill_category = "Programming"
  when 1
    skill_name = Faker::Music.instrument
    skill_description = "Learn how to play the #{skill_name}!"
    skill_category = "Music"
  when 2
    skill_name = Faker::Team.sport.capitalize
    skill_description = "Learn how to play #{skill_name}!"
    skill_category = "Sports"
  when 3
    skill_name = "Cooking #{Faker::Food.dish}"
    skill_description = "learn how to cook a delicious #{skill_name[8..-1]}"
    skill_category = "Cooking"
  end

  s = t.skills.create(
    name: skill_name,
    description: skill_description,
    category: skill_category,
    availability: skill_availability,
    price: (20..60).to_a.sample)
  s.update_columns(
    location: address['formatted_address'],
    formatted_address: address['formatted_address'],
    latitude: address['latitude'],
    longitude: address['longitude'])
  puts i
end

