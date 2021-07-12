
User.delete_all

# User.create!(email: "uni@example.com", password: "foobar")

users = [
  {
    email: "uni@example.com",
    encrypted_password: "$2a$12$oM9id83/3mO9csK1xSQIUO8xjP6I3GFfXW66jPrh24n48srgqXZPS"
  },
  {
    email: "ruby@example.com",
    encrypted_password: "$2a$12$oM9id83/3mO9csK1xSQIUO8xjP6I3GFfXW66jPrh24n48srgqXZPS"
  }
]

time = Time.now
users.each{
  _1[:created_at] = time
  _1[:updated_at] = time
  _1[:encrypted_password] = "$2a$12$oM9id83/3mO9csK1xSQIUO8xjP6I3GFfXW66jPrh24n48srgqXZPS"
}

User.upsert_all(users)
