require 'random_data'

# # Create Users
# 5.times do
#   User.create!(
#   email:    RandomData.random_email,
#   password: RandomData.random_sentence
#   )
# end
#
# # Create custom user
# User.create!(
# email:    'seanmross9@gmail.com',
# password: 'password',
# password_confirmation: 'password',
# confirmed_at: Time.at(0)
# )
#
# users = User.all


# Create Wikis
50.times do
  Wiki.create!(
    #user:   users.sample,
    title:  RandomData.random_sentence,
    body:   RandomData.random_paragraph
  )
end
wikis = Wiki.all

# Output data summary
puts "Seed finished"
#puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"
