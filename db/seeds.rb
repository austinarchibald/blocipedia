require 'faker'

# Create Users
5.times do
  user = User.new(
    name:     Faker::Name.name,
    email:    Faker::Internet.email,
    password: Faker::Lorem.characters(8)
  )
  user.skip_confirmation!
  user.save!
end
users = User.all

# Create public wikis
20.times do
  Wiki.create!(
    title:   Faker::Lorem.sentence,
    body:    Faker::Lorem.paragraph,
    private: false,
    user:    users.sample
  )
end
# Create private wikis
10.times do
  Wiki.create!(
    title:   Faker::Lorem.sentence,
    body:    Faker::Lorem.paragraph,
    private: true,
    user:    users.sample
  )
end

# Create an admin user
admin = User.new(
  name:     'Admin User',
  email:    'admin@example.com',
  password: 'password',
  role:     'admin'
)
admin.skip_confirmation!
admin.save!

# Create a free user
free = User.new(
  name:     'Free User',
  email:    'free@example.com',
  password: 'password',
  role:     'free'
)
free.skip_confirmation!
free.save!

# Create a premium user
premium = User.new(
  name:     'Premium User',
  email:    'premium@example.com',
  password: 'password'
)
premium.skip_confirmation!
premium.save!

# Create me
me = User.new(
  name:     'Austin Peay',
  email:    'theaustinpeay@gmail.com',
  password: 'password',
  role:     'admin'
)
me.skip_confirmation!
me.save!

puts "Seed finished"
puts "#{User.count} users created."
puts "#{Wiki.count} wikis created."