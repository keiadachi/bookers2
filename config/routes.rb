Rails.application.routes.draw do

  devise_for :users
  root to: 'homes#top'

  resources :books, only: [:create, :show, :index, :destroy, :edit, :update]

  resources :homes
  #個別に設定

  resources :users

end
