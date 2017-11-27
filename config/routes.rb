Rails.application.routes.draw do
  devise_for :users,
  controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :skill
  resources :lessons
  root to: 'pages#home'

end
