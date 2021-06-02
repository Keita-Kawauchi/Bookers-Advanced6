Rails.application.routes.draw do
  devise_for :users
  root 'homes#top'
  get 'homes/about' => 'homes#about'
  resources :users,only: [:show,:index,:edit,:update]
  resources :books
end