class BooksController < ApplicationController
# 画像投稿の画面を表示するアクションメソッド

# 各アクション実行前に実行したい処理指定
before_action :is_matching_login_user, only: [:edit]
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
# フラッシュメッセージ(books/showへリンク)
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book.id)
# バリデーションで保存できなかった時はsaveメソッドがfalseになり、renderでbooks/new.html.erbが表示され投稿ページを再表示する設定
    else
      @books = Book.all
# @userを定義
      @user = current_user
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
# @userを定義
    @user = current_user
# @bookを定義
    @book = Book.new
  end
# 詳細画面が表示されるように設定
  def show
    @book = Book.find(params[:id])
# @userを定義
    @user = @book.user
    @book_new = Book.new
  end

# 投稿を削除するdestroyアクションの処理(投稿の削除後は一覧に遷移)記述
  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  def edit
    @book = Book.find(params[:id])
    # unless @book.id == current_user.id
    #   redirect_to books_path
    # end
  end

  def update
# フォームに入力されたデータ(body,title,image)が@bookに格納される
    @book = Book.find(params[:id])
 # @book(投稿データ)のuser_idを、current_user.id(今ログインしているユーザーのID)に指定することで投稿データに、今ログイン中のユーザーのIDを持たせる
    if @book.update(book_params)
# フラッシュメッセージ(books/showへリンク)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book.id)
# バリデーションで保存できなかった時はsaveメソッドがfalseになり、renderでbooks/new.html.erbが表示され投稿ページを再表示する設定
    else
      render :edit

    end
  end


  private

# book_paramsメソッドでフォームで入力されたデータが、投稿データとして許可されているパラメータかどうかをチェック
  def book_params
    params.require(:book).permit(:title, :image, :body)
  end
  
# アクセス制限
  def is_matching_login_user
    @book = Book.find(params[:id])
    unless @book.id == current_user.id
      redirect_to books_path
      
    end
  end
  end