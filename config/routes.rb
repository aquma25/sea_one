Rails.application.routes.draw do

  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: 'users/registrations',
    confirmations: 'users/confirmations',
    passwords: 'users/passwords',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  devise_scope :user do
    get 'users/mail_sent', to: 'users/registrations#mail_sent'
  end

  root to: "tops#index"
  resources :tops, only: [:index]

  #=> post 'csv_uploads/csv_import', to: 'csv_uploads#csv_import'
  # 下記２通りの書き方が使用出来る(collectionとmemberはpathにidを伴うか否か)
  resources :csv_uploads do
    collection { post :csv_import }
    get 'csv_export', on: :member
  end
end
