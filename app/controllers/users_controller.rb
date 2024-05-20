class UsersController < ApplicationController
# ユーザの詳細ページ
# URLに記載されたIDを参考に、必要なUserモデルを取得する処理
  def show
# エラー時にroutesの順番が関係しているかも
    @user = User.find(params[:id])
# kaminariインストール後変更
    @books = @user.books.page(params[:page])
    @book = Book.new
# 特定のユーザ（@user）に関連付けられた投稿全て（.books）を取得し@booksに渡す処理を行う
    # @books = @user.books
  end
# 編集機能用のアクションを定義
  def edit
    @user = User.find(params[:id])
  end
# 更新機能を作成
  def update
    @user = User.find(params[:id])
    @user.update(user_params)
# サクセスメッセージ（successfullyの言葉が含む）
    flash[:success] = "Welcome! You have signed up successfully."
    redirect_to user_path(user.id)
  end
# ユーザ一覧作成
  def index
# 現在ログインしているユーザ（自分）
    @user = current_user
# 上書きされるので@userを複数形にする
    @users = User.all
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image)
  end
end
