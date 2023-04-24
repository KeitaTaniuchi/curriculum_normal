puts 'users ...'

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