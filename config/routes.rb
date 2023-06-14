Rails.application.routes.draw do
  resources :users, path: 'users/profiles'
  devise_for :users
  root 'static_pages#home'
end
