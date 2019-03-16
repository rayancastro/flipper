Rails.application.routes.draw do

  devise_for :users
  root to: 'pages#home'

  resources :leads
  post '/change_lead_stage', to: "leads#change_lead_stage"
  resources :contacts
  resources :activities
  resources :notes, only: [:create, :destroy]
  resources :lead_backlogs, only: [:index]
  resources :goals, except: [:show] do 
    post 'create_user_goals_for_all', to: 'goals#create_user_goals_for_all'
    delete 'destroy_user_goals_for_all', to: 'goals#destroy_user_goals_for_all' 
  end

  resources :users, only: [:update]

  get '/challenges', to: 'pages#challenges'
  get '/user_profile', to: 'users#user_profile'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
