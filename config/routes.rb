Rails.application.routes.draw do

  devise_for :users
  root to: 'homes#top'

  resources :books
  
  resources :homes
  
  resources :users
  
  resources :post_images
  

end
