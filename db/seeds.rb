p "Start seeding"
user = User.create( 
        email: 'test@test.test',
        first_name: "john",
        last_name: "snow",
        password: "asdfasdf",
        password_confirmation: "asdfasdf",
      )
AdminUser.create( 
        email: 'admin@user.test',
        first_name: "adminF",
        last_name: "adminL",
        password: "asdfasdf",
        password_confirmation: "asdfasdf",
      )
100.times do |n|
  Post.create!(
    date: Date.today, 
    rationale: "#{n} rationale content", 
    user_id: user.id
  )
end
p "100 Posts have been created"