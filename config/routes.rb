Rails.application.routes.draw do

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  root to: "home#top"

  get "/home/about" => "home#about", as: "about"
  resources :books, only: [:new, :index, :show, :create, :destroy, :edit, :update]
  resources :users, only: [:show, :edit, :update, :index]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
