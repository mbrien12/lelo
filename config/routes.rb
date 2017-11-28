Rails.application.routes.draw do
  devise_for :users,
  controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :skills
  resources :lessons, only: [:index, :create, :show, :update]
  resources :messages, only: [:index, :create, :show, :new]
  root to: 'pages#home'

end
