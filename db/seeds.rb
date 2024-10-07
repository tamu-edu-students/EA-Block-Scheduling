# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

users = [
  { username: 'testuser1', first_name: 'test', last_name: 'testuser1', email: 'testuser1@test.com' },
  { username: 'testuser2', first_name: 'test', last_name: 'testuser2', email: 'testuser2@test.com' }
]

users.each do |user|
  User.where(username: user[:username], first_name: user[:first_name], last_name: user[:last_name], email: user[:email]).first_or_create
end
