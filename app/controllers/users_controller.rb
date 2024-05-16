class UsersController < ApplicationController
# ユーザの詳細ページ
# URLに記載されたIDを参考に、必要なUserモデルを取得する処理
  def show
    @user = User.find(params[:id])
# 特定のユーザ（@user）に関連付けられた投稿全て（.books）を取得し@booksに渡す処理を行う
    @books = @user.books
  end

  def edit
  end
end
