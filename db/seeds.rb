# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# db/seeds.rb

# Create sample users
u = User.new(username: 'user1', email: 'user1@example.com', password: 'password1', password_digest: 'password1')
u.save!

u = User.new(username: 'user2', email: 'user2@example.com', password: 'password2', password_digest: 'password2')
u.save!
puts "Users created successfully"

# Create sample posts for each user
user1 = User.find_by(email: 'user1@example.com')
user2 = User.find_by(email: 'user2@example.com')

p = Post.new(title: 'First Post', content: 'This is the content of the first post by user1.', user: user1)
p.save
p = Post.new(title: 'Second Post', content: 'This is the content of the second post by user1.', user: user1)
p.save
p = Post.new(title: 'Third Post', content: 'This is the content of the first post by user2.', user: user2)
p.save

puts "Posts created successfully"
