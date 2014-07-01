namespace :db do
    desc "Inserisco faker data + admin nel db"
    task populate: :environment do
      puts "Popolo il database..."
      admin = User.create!(name: "Marika Pinori",
                          email: "marika.pinori@polito.it",
                          password: "pass2014",
                          password_confirmation: "pass2014")
      admin.toggle!(:admin)
      puts "... utente admin creato"
      99.times do |n|
        name  = Faker::Name.name
        email = "example-#{n+1}@lam.it"
        password  = "password"
        User.create!(name: name,
                     email: email,
                     password: password,
                     password_confirmation: password)
      end
      puts "... 99 utenti creati"

      # genero 50 fake posts per i primi 10 utenti
      users = User.all(limit: 10)
      50.times do
         post_title = Faker::Lorem.sentence(3)
         post_content = Faker::Lorem.paragraph
         users.each { |user| user.posts.create!(title: post_title, content: post_content )}
      end
      puts "... creati 50 posts per i primi 10 utenti"

    end
end