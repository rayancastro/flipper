Rails.application.routes.draw do

  devise_for :users
  root to: 'pages#home'

  resources :leads
  post '/change_lead_stage', to: "leads#change_lead_stage"
  resources :contacts
  resources :activities
  resources :notes, only: [:create, :destroy]
  resources :lead_backlogs, only: [:index]
  post 'create_goals_for_all', to: 'goals#create_goals_for_all' 
  resources :goal_types, except: [:show]


  get '/challenges', to: 'pages#challenges'
  get '/control_panel', to: 'pages#control_panel'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
