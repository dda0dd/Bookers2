class ApplicationController < ActionController::Base
# devise利用の機能（ユーザ登録、ログイン認証）が使用前にconfigure_permitted_parametersメソッドが実行される
  before_action :configure_permitted_parameters, if: :devise_controller?

# ログイン後の遷移先を投稿画像一覧画面に設定
  def after_sign_in_path_for(resource)
    book_path
  end

# after_sign_in_path_forはサインイン後にどこに遷移するか設定しているメソッド
  # def after_sign_in_path_for(resource)
  #   about_path
  # end
# resourceという引数には、ログインを実行したモデルのデータ（今回の場合はログインしたUserのインスタンス）が格納されている

# after_sign_out_path_forはサインアウト後にどこに遷移するかを設定しているメソッド
  def after_sign_out_path_for(resource)
    about_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

# devise_parameter_sanitizer.permitメソッド使用でユーザー登録(sign_up)時にユーザー名(name)のデータ操作を許可している
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
