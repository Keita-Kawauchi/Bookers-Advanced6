Rails.application.routes.draw do
  devise_for :users
  root 'homes#top'
  get 'home/about' => 'homes#about'
  resources :users, only: [:show,:index,:edit,:update]
  resources :books do
  resources :profile_images, only: [:new, :create, :index, :show, :destroy]
  resources :book_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
end