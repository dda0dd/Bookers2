class BooksController < ApplicationController
# 画像投稿の画面を表示するアクションメソッド
  def new
# form_withに渡すための「空のモデル」を用意
    @book = Book.new
  end

# 投稿データを保存するためにcreateアクションを記述
  def create
# フォームに入力されたデータ(body,title,image)が@bookに格納される
    @book = Book.new(book_params)
# @book(投稿データ)のuser_idを、current_user.id(今ログインしているユーザーのID)に指定することで投稿データに、今ログイン中のユーザーのIDを持たせる
    @book.user_id = current_user.id
    @book.save
    redirect_to books_path
  end

# 投稿一覧で表示する全ての画像をコントローラで取得
  def index
    @book = Book.all
  end
# 詳細画面が表示されるように設定
  def show
    @book = Book.find(params[:id])
  end

# 投稿を削除するdestroyアクションの処理(投稿の削除後は一覧に遷移)記述
  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to Books_path
  end


  private

# book_paramsメソッドでフォームで入力されたデータが、投稿データとして許可されているパラメータかどうかをチェック
  def book_params
    params.require(:book).permit(:title, :image, :body)
  end
end
