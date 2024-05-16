class CreateBooks < ActiveRecord::Migration[6.1]
  # 投稿画像の管理用テーブル

  def change
    create_table :books do |t|
# t.データ型 :カラム名
      t.timestamps
# 本のタイトル
      t.string :title
# 感想
      t.string :body
# 投稿ユーザを識別する
      t. integer :user_id
    end
  end
end
