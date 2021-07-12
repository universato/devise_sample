# Devise Sample

`rails g devise User`
deviseの小文字・大文字は区別され、すべて小文字のdeviseのみ。
既存のUserモデルがあれば、追加する形で作られる。

`rails d devise --help`で、
`rails d devise --help`で、`rails generate devise NAME [options]`という用法を見れる。

```
$ rails g --help | grep devise
  active_record:devise
  devise
  devise:controllers
  devise:install
  devise:views
  mongoid:devise
```

# Links

|URL  |Action|
|:--- |:---  |
|http://localhost:3000/rails/info/routes  |-
|http://localhost:3000/users/sign_in      |devise/sessions#new    
|http://localhost:3000/users/sign_up      |devise/registrations#new
|http://localhost:3000/users/edit         |devise/registrations#edit
|http://localhost:3000/users/password/new |devise/passwords#new
|http://localhost:3000/users/password/edit|devise/passwords#edit

# User.column_names


[migrate](/db/migrate/)
```rb
class DeviseCreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      t.timestamps null: false
    end

    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
  end
end
```
↓
```rb
User.column_names
# => ["id", "email", "encrypted_password", "reset_password_token", "reset_password_sent_at", "remember_created_at", "created_at", "updated_at"]

[
  "id",
  "email",
  "encrypted_password",
  "reset_password_token",
  "reset_password_sent_at",
  "remember_created_at",
  "created_at",
  "updated_at"
]
```
