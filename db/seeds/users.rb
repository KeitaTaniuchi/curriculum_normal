puts 'Start creating administrator ...'
User.create!(
  last_name: "谷内",
  first_name: "圭太",
  email: "barbaakonta1995@gmail.com",
  password: "keita1995",
  password_confirmation: "keita1995"
)
puts '✨Finish creating administrator!!'

puts 'Start creating users ...'
10.times do |n|
  User.create!(
    last_name: Faker::Name.unique.last_name,
    first_name: Faker::Name.unique.first_name,
    email: Faker::Internet.unique.email,
    password: "test",
    password_confirmation: "test"
  )
  puts "users = #{User.count}"
end
puts '✨Finish creating users!!'