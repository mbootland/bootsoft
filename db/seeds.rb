# frozen_string_literal: true

User.destroy_all

# Add admin user
User.create(
  username: 'admin',
  email: 'admin@example.com',
  password: 'password',
  is_admin: true,
  is_active: true
)

Post.destroy_all

Post.create(
  title: 'My first post',
  body: 'This is the body of my first post',
  user: User.first
)

Post.create(
  title: 'My second post',
  body: 'This is the body of my second post',
  user: User.first
)
