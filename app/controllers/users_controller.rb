class UsersController < ApplicationController
# ユーザの詳細ページ

# 各アクション実行前に実行したい処理指定
# before_action :is_matching_login_user, only: [:edit]
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
    unless @user.id == current_user.id
      redirect_to user_path(current_user.id)
    end
  end
# 更新機能を作成
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
# サクセスメッセージ（successfullyの言葉が含む）
  # users/showへリンク
    flash[:notice] = "You have updated user successfully."
    redirect_to user_path(@user.id)
  else
    render :edit
  end
  end
# ユーザ一覧作成
  def index
# 現在ログインしているユーザ（自分）
    @user = current_user
# 上書きされるので@userを複数形にする
    @users = User.all
    @book = Book.new
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

# アクセス制限
  # def is_matching_login_user
  #   @user = User.find(params[:id])
  #   unless user.id == current_user.id
  #     redirect_to users_path
  #   end
  # end
end
