class User < ApplicationRecord
# Include default devise modules. Others available are:
# :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

# 1:Nの「1」側にあたるモデル(1人のユーザーが何をたくさん持っているか？という定義)
  has_many :books, dependent: :destroy
# profile_imageという名前でActiveStorageでプロフィール画像を保存できるように設定
  has_one_attached :profile_image

# nameが存在しているかを確認するバリデーション(uniqueness:一意性)
  validates :name, presence: true, uniqueness: true, length: {in: 2..20}
# introductionが存在しているかを確認するバリデーション(maximum:最大文字数)
  validates :introduction, length: {maximum: 50}
# エラー表示（引数の数が間違っている）
  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/sample-author1.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
# メソッドに対して引数を設定し、引数に設定した値に画像のサイズを変換
    profile_image.variant(resize_to_limit: [width,height]).processed
  end
end
