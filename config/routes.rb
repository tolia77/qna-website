Rails.application.routes.draw do
  resources :issues
  resources :answers, only: [] do
    resources :comments, except: :show
  end
  resources :questions, shallow: true do
    resources :answers, only: [:new, :create, :edit, :update, :destroy]
  end
  resources :categories, except: :show do
    resources :questions, only: :index
  end
  get 'categories/search/:key', to: 'categories#search'
  get 'categories/searchtest'
  resources :posts
  resources :users, path: 'users/profiles' do
    resources :questions, only: :index
    resources :answers, only: :index
  end
  devise_for :users
  root 'static_pages#home'
end
