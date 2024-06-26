Rails.application.routes.draw do
# routesの記述順番に気を付ける（優先順位）

# devise使用時にURLとしてusersを含む記述
  devise_for :users

# onlyオプションで生成するルーティングを限定（新規投稿、一覧、詳細機能、削除）
  resources :books, only: [:new, :create, :index, :show, :destroy, :edit, :update]
# resourcesとonlyを使って、show, editのアクションのみ追加
# only: []内にupdateを追加
  resources :users, only: [:show, :edit, :update, :index]

# getからroot to（ルートパス設定）に変更
  root to: 'homes#top'

# 名前付きルートパス（名:about）に設定
  # '/homes/about'を'/home/about'に変更
  get '/home/about', to: 'homes#about', as: 'about'
# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
