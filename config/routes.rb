Rails.application.routes.draw do

  devise_for :users
  root to: 'homes#top'

  resources :books
  
  get "home/about" => "homes#about"
  #個別に設定

  resources :users
  
end
