class ApplicationController < ActionController::Base
# ログインしていない状態でトップページ以外にアクセスされた時に、ログイン画面へリダイレクトする設定
  # aboutページにも許可追記（ログイン前に開けるように）
  before_action :authenticate_user!, except: [:top, :about]
# devise利用の機能（ユーザ登録、ログイン認証）が使用前にconfigure_permitted_parametersメソッドが実行される
  before_action :configure_permitted_parameters, if: :devise_controller?

# ログイン後の遷移先を投稿画像一覧画面に設定
  def after_sign_in_path_for(resource)
# ログインした直後は、ユーザーの詳細ページに遷移
    user_path(resource)
  end

# after_sign_in_path_forはサインイン後にどこに遷移するか設定しているメソッド
  # def after_sign_in_path_for(resource)
  #   about_path
  # end
# resourceという引数には、ログインを実行したモデルのデータ（今回の場合はログインしたUserのインスタンス）が格納されている

# after_sign_out_path_forはサインアウト後にどこに遷移するかを設定しているメソッド
  def after_sign_out_path_for(resource)
    root_path
  end

  protected

# devise_parameter_sanitizer.permitメソッド使用でユーザー登録(sign_up)時にユーザー名(name)のデータ操作を許可している
  def configure_permitted_parameters
# nameからemailに変更（config/initializers/devise.rbのconfig.authentication_keys = [:name]変更したため）
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end
end
