Rails.application.routes.draw do
  resources :issues
  resources :answers, only: [] do
    resources :comments, only: [:new, :edit, :create, :update, :destroy]
  end
  resources :questions, shallow: true do
    resources :answers, only: [:new, :create, :edit, :update, :destroy]
  end
  resources :categories, only: [:index, :new, :create, :edit, :update, :destroy] do
    resources :questions, only: :index
  end
  resources :posts
  resources :users, path: 'users/profiles' do
    resources :questions, only: :index
    resources :answers, only: :index
  end
  devise_for :users
  root 'static_pages#home'
end
