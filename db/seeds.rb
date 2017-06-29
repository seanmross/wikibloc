unless Rails.env.production? do

  require 'random_data'

  # Create Users
  5.times do
    User.create!(
    email:    Faker::Internet.unique.email,
    password: 'password',
    password_confirmation: 'password',
    confirmed_at: Time.at(0)
    )
  end

  # Create custom admin user
  User.create!(
  email:    'admin@example.com',
  password: 'password',
  password_confirmation: 'password',
  confirmed_at: Time.at(0),
  role: 'admin',
  )

  # Create custom premium user
  User.create!(
  email:    'premium@example.com',
  password: 'password',
  password_confirmation: 'password',
  confirmed_at: Time.at(0),
  role: 'premium',
  )

  # Create custom standard user
  User.create!(
  email:    'standard@example.com',
  password: 'password',
  password_confirmation: 'password',
  confirmed_at: Time.at(0),
  role: 'standard',
  )


  users = User.all


  # Create Wikis
  50.times do
    Wiki.create!(
      user:    users.sample,
      title:   RandomData.random_sentence,
      body:    RandomData.random_paragraph,
      private: Faker::Boolean.boolean
    )
  end
  wikis = Wiki.all

  # Output data summary
  puts "Seed finished"
  puts "#{User.count} users created"
  puts "#{Wiki.count} wikis created"
  puts "#{Collaboration.count} collaborations created"

end
