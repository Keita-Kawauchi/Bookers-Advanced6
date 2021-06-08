Rails.application.routes.draw do
  devise_for :users
  root 'homes#top'
  get 'home/about' => 'homes#about'

  resources :users, only: [:index, :show, :edit, :update] 
  resources :relationships, only: [:create, :destroy]
  get 'followings' => 'relationships#followings', as: 'followings'
  get 'followers' => 'relationships#followers', as: 'followers'
  

  resources :books do
   resource :favorites, only: [:create, :destroy]
  resources :book_comments, only: [:create, :destroy]

  end
end