Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :events
  root 'visitors#index'
  get '/schedule' => 'visitors#schedule'
  get '/generate_bill/:id' => 'visitors#generate_bill'
end
