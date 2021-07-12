class UsersController < ApplicationController
  # authenticate_user!
  # ユーザーがログインしているかどうか確かめ、未ログインの場合はログイン画面へリダイレクトする。
  # https://github.com/heartcombo/devise/blob/5d5636f03ac19e8188d99c044d4b5e90124313af/lib/devise/controllers/helpers.rb#L116-L119
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end
end
