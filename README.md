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


```rb
$ git push heroku main
(中略)
remote: -----> Ruby app detected
remote: -----> Installing bundler 2.2.21
remote: -----> Removing BUNDLED WITH version in the Gemfile.lock
remote: -----> Compiling Ruby/Rails
remote: -----> Using Ruby version: ruby-3.0.2
remote: -----> Installing dependencies using bundler 2.2.21
remote:        Running: BUNDLE_WITHOUT='development:test' BUNDLE_PATH=vendor/bundle BUNDLE_BIN=vendor/bundle/bin BUNDLE_DEPLOYMENT=1 bundle install -j4
remote:        Your bundle only supports platforms ["x86_64-darwin-20"] but your local platform
remote:        is x86_64-linux. Add the current platform to the lockfile with `bundle lock
remote:        --add-platform x86_64-linux` and try again.
remote:        Bundler Output: Your bundle only supports platforms ["x86_64-darwin-20"] but your local platform
remote:        is x86_64-linux. Add the current platform to the lockfile with `bundle lock
remote:        --add-platform x86_64-linux` and try again.
remote: 
remote:  !
remote:  !     Failed to install gems via Bundler.
remote:  !
```

変に改行されて読みにくい。文単位で改行してみる。
Your bundle only supports platforms ["x86_64-darwin-20"] but your local platform is x86_64-linux. 
Add the current platform to the lockfile with `bundle lock --add-platform x86_64-linux` and try again.

"x86_64-darwin-20"ってのがmacOSの1つで、Herokuの環境がLinuxで`x86_64-linux`でも使われることを指定しろって話みたい。
nokogiriとかは、環境によって、ちょっと異なるバージョンが入るらしい。環境ごとにバージョンがあるって感じなのかな。

```rb
remote: -----> Ruby app detected
remote: -----> Installing bundler 2.2.21
remote: -----> Removing BUNDLED WITH version in the Gemfile.lock
remote: -----> Compiling Ruby/Rails
remote: -----> Using Ruby version: ruby-3.0.2
remote: -----> Installing dependencies using bundler 2.2.21
```

Rubyで作られたアプリだと検知して、bundler 2.2.21をインストールし始める。
Gemfile.lockに書かれたBundlerのバージョンを削除する。
で、2.2.21 bundlerを使って、Gemfile.lockからインストールしてる。


# Deviseで作ったユーザー

```rb
User.new(email: "foo@example.com", password: "foobar")
```

`User.new`するときは`password`でよいが、中のカラムは`encrypted_password`.
