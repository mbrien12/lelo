require 'faker'

puts 'Cleaning database...'
Review.destroy_all
Message.destroy_all
Skill.destroy_all
User.destroy_all



googleAddresses = JSON.parse(open("db/google_addresses.json").read)
teachers = JSON.parse(open("db/random_teachers.json").read)['results']

googleAddresses.each_with_index do |address,i|
  teacher = teachers[i]
  t = Teacher.new
  (
    email: teacher['email']
    password: '123456'
    frist_name: teacher['name']['frist_name']
    last_name: teacher['name']['last_name']
    remote_photo_url: teacher['picture']['large']
  )

  t.save


end
