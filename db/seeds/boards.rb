puts 'Start creating boards ...'
2.times do |n|
  User.limit(10).each do |user|
    user.boards.create!(
      title: Faker::Job.title,
      body: Faker::Hacker.say_something_smart
    )
    puts "boards = #{Board.count}"
  end
end
puts '✨Finish creating boards!!'