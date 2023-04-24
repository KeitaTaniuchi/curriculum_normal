puts 'posts ...'

2.times do |n|
  User.limit(10).each do |user|
    user.boards.create!(
      title: Faker::Name.unique.name,
      body: Faker::Hacker.say_something_smart
    )
    puts "posts = #{Board.count}"
  end
end