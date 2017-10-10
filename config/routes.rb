Rails.application.routes.draw do
  resources :pages
  mount Ckeditor::Engine => '/ckeditor'
  root to: "home#index"
  get "home/index"
  get "get_user", to: "home#get_user"

  devise_for :users, controllers: {
      sessions: 'users/sessions'
  }

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
