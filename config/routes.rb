Rails.application.routes.draw do
  get 'applicants_controller/show'

  root to: "home#index"
  get "home/index"
  get "get_user", to: "home#get_user"
  get "unlock_user", to: "application#user_unlock", as: :user_unlock

  devise_for :users, controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations',
      unlocks: 'users/unlocks'
  }
  namespace :applicants do
    get "profile"
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
