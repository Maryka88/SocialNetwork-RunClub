namespace :db do
    desc "Inserisco faker data + admin nel db"
    task populate: :environment do
      puts "Popolo il database..."
      make_users
      make_posts
      make_relationships
      make_private_messages
    end
end

def make_users
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
end

def make_posts
    # genero 50 fake posts per i primi 10 utenti
    users = User.all(limit: 10)
    50.times do
      post_title = Faker::Lorem.sentence(3)
      post_content = Faker::Lorem.paragraph
      users.each { |user| user.posts.create!(title: post_title, content: post_content )}
    end
    puts "... creati 50 posts per i primi 10 utenti"
end

def make_relationships
    users = User.all
    user = users.first
    followed_users = users[2..50]
    followers = users[3..40]

    followed_users.each { |followed| user.follow!(followed) }
    puts "... il primo utente segue gli utenti da 3 a 51, ora!"

    followers.each { |follower| follower.follow!(user) }
    puts "... il primo utente viene seguito dagli utenti da 4 a 41, ora!"
end

def make_private_messages
    # genero 10 messaggi fake per il primo utente
    first_user = User.first
    users = User.all
    message_from_users = users[3..12]
    message_from_users.each do |user|
    msg_body = Faker::Lorem.sentence(8)
    msg_subject = Faker::Lorem.sentence(3)
    message = Message.new
    message.sender = user
    message.recipient = first_user
    message.subject = msg_subject
    message.body = msg_body
    message.save!
    end
    puts "... creati 10 messaggi per il primo utente"
end