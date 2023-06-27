Rails.application.routes.draw do
  resources :questions, shallow: true do
    resources :answers
  end
  resources :tags
  resources :categories
  resources :posts
  resources :users, path: 'users/profiles'
  devise_for :users
  root 'static_pages#home'
end
