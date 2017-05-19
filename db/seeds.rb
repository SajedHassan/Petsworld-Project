# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#Users
User.create!(user_name: "Admin",
	email: "Admin@petsworld.com",
	password: "project",
	password_confirmation: "project",
	admin: true)

99.times do |n|
	name = Faker::Name.name
	email = "example-#{n+1}@petsworld.com"
	password = "password"
	User.create!(user_name: name,
		email: email,
		password: password,
		password_confirmation: password)
end

#activate emails
users = User.all
users.each do |user| 
	user.email_confirm = true
end

#Posts
users = User.order(:created_at).take(6)
10.times do
	content = Faker::Lorem.sentence(5)
	users.each { |user| user.posts.create!(content: content , all_tags: "tag") }
end

# Following relationships
users = User.all
user = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }