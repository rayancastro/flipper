Rails.application.routes.draw do

  devise_for :users
  root to: 'pages#home'

  resources :leads
  resources :contacts
  resources :activities
  resources :notes, only: [:create, :destroy]

  get '/challenges', to: 'pages#challenges'
  get '/control_panel', to: 'pages#control_panel'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
