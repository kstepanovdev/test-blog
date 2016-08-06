namespace :db do
  desc "Fill database with users"
  task populate: :environment do
    admin = User.create!(nickname: 'admin',
                email: 'admin@blog.com',
                password: 'password',
                password_confirmation: 'password',
                admin: true)
    
    99.times do |n|
      nickname = Faker::Name.first_name
      email = "example-#{n+1}@example.org"
      password = "password"
      User.create!(nickname: "#{nickname}#{n+1}",
                   email: email,
                   password: password,
                   password_confirmation: password)
    end

    users = User.limit(20)
    50.times do |n|
      title = Faker::Lorem.sentence(1)
      content = Faker::Lorem.sentence(5)
      users.each { |user| user.posts.create!(title: title, content: content) }
    end
  end
end
