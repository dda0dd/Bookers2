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
    if @book.save
      redirect_to book_path(@book.id)
# バリデーションで保存できなかった時はsaveメソッドがfalseになり、renderでbooks/new.html.erbが表示され投稿ページを再表示する設定
    else
      @books = Book.all
      render :index
    end
  end

# 投稿一覧で表示する全ての画像をコントローラで取得
  def index
# 1ページ分の決められた数のデータだけを、新しい順に取得するに変更(kaminari)
  # 今回ページネーションは必要ない
    # @books = Book.page(params[:page])
# modelを全て選択
    @books = Book.all
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

  def edit
  end

  def update
  end


  private

# book_paramsメソッドでフォームで入力されたデータが、投稿データとして許可されているパラメータかどうかをチェック
  def book_params
    params.require(:book).permit(:title, :image, :body)
  end
end
