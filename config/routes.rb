Rails.application.routes.draw do

  get 'relationships/followings'
  get 'relationships/followers'
  get 'favorites/create'
  get 'favorites/destroy'
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  root to: "home#top"

  get "/home/about" => "home#about", as: "about"
  
  resources :books, only: [:new, :index, :show, :create, :destroy, :edit, :update] do
    resource :favorite, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end 
  
  resources :users, only: [:show, :edit, :update, :index] do
     member do
       get :follows, :followers
     end 
    get "posts_on_date" => "users#posts_on_date"
     
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end
  
  resources :messages, only: [:create]
  resources :rooms, only: [:create, :show]
  
  get "search" => "searches#search"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
