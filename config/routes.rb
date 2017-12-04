Rails.application.routes.draw do

  devise_for :users,
  controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :skills do
    post 'lesson_sms',to: 'notifications#notify_lesson_request'
    resources :reviews, only: :create
  end
  resources :lessons, only: [:index, :create, :show, :update]
  resources :messages, only: [:index, :create, :show, :new]
  resources :profiles, only: :show
  root to: 'pages#home'

end
