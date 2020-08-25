Rails.application.routes.draw do

  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: 'users/registrations',
    confirmations: 'users/confirmations'
  }

  devise_scope :user do
    get 'users/mail_sent' => 'users/registrations#mail_sent'
  end

  root to: "tops#index"
  resources :tops, only: [:index]
end
