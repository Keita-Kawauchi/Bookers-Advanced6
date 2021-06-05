Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show,:index,:edit,:update]
  resources :books
  resources :profile_images, only: [:new, :create, :index, :show, :destroy]
  root 'homes#top'
  get 'home/about' => 'homes#about'
end