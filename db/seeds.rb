# db/seeds.rb


puts "Cleaning database..."
Comment.destroy_all
Post.destroy_all
User.destroy_all

puts "Creating users..."
users = [
  User.create!(user_name: "mru", email: "mru@example.com", password: "password"),
  User.create!(user_name: "IamAdmin", email: "admin@example.com", password: "password"),
  User.create!(user_name: "JaneDoe", email: "jane@example.com", password: "password")
]

puts "Creating posts..."
posts = [
  Post.create!(
    title: "My First Post",
    content: "Hello guys, how is your day going???",
    user_id: users[0].id,
    views: 40
  ),
  Post.create!(
    title: "Admin Announcement",
    content: "System maintenance scheduled for tomorrow.",
    user_id: users[1].id,
    views: 20
  ),
  Post.create!(
    title: "Fun Fact",
    content: "Did you know? Rails was first released in 2004!",
    user_id: users[2].id,
    views: 10
  )
]

puts "Creating comments..."
Comment.create!(
  content: "good post mru!!",
  post_id: posts[0].id,
  user_id: users[0].id
)

Comment.create!(
  content: "Nice post",
  post_id: posts[0].id,
  user_id: users[1].id
)

Comment.create!(
  content: "Thanks for sharing!",
  post_id: posts[2].id,
  user_id: users[0].id
)

puts "Seeding completed!"