class Book < ApplicationRecord
# ActiveStorageを使って画像を持たせる記述を追加
  has_one_attached :image

# 1:Nの「N」側にあたるモデル(Bookモデルに関連付けられるのは1つのUserモデルのため単数形の「user」)
  belongs_to :user
  
# titleが存在しているかを確認するバリデーション(空でないように設定)
  validates :title, presence: true
# bodyが存在しているかを確認するバリデーション
  validates :body, presence: true, length: {maximum: 200}
# imageが存在しているかを確認するバリデーション
  # validates :image, presence: true
# 一覧機能で画像表示
  # def get_image
  #   if image.attached?
  #     image
  #   else
  #     'no_image.jpg'
  #   end
  # end

# 画像が設定されない時にno_image.jpg（画像）をデフォルト画像としてActiveStorageに格納、その画像を表示する
  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end
end
