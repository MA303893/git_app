Rails.application.routes.draw do
  # devise_for :admin_users, ActiveAdmin::Devise.config
  devise_for :admin_users,  ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root to: "home#index"
  get "home/index"
  get "get_user", to: "home#get_user"

  devise_for :users, controllers: {
      sessions: 'users/sessions'
  }
  # get '/users/sign_in(.:format)', to: 'users/sessions#new', as: 'new_user_session'
  # post '/users/sign_in(.:format)', to: 'users/sessions#create', as: 'user_session'
  # delete '/users/sign_out(.:format)', to: 'users/sessions#destroy', as: 'destroy_user_session'
  # get '/users/password/new(.:format)', to: 'devise/passwords#new', as: 'new_user_password'
  # get '/users/password/edit(.:format)', to: 'devise/passwords#edit', as: 'edit_user_password'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
