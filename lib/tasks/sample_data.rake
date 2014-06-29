namespace :db do
    desc "Inserisco faker data + admin nel db"
    task populate: :environment do
      admin = User.create!(name: "Marika Pinori",
                          email: "marika.pinori@polito.it",
                          password: "pass2014",
                          password_confirmation: "pass2014")
      admin.toggle!(:admin)
      99.times do |n|
        name  = Faker::Name.name
        email = "example-#{n+1}@lam.it"
        password  = "password"
        User.create!(name: name,
                     email: email,
                     password: password,
                     password_confirmation: password)
      end
    end
end