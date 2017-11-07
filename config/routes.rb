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
    # get "", to: "#qualifications_and_licences"
    get "experiences"
    get "extra"
    get "referals"
  end
  match "applicants/qualifications", to: "applicants#qualifications_and_licences", :via => [:get]
  get 'timezones', to: "application#timezones"
  get 'languages', to: "application#languages"
  get 'countries', to: "application#countries"
  get 'states', to: "application#states"

  #Update applicant profile
  post 'applicants/profile/picture', to: 'applicants#update_picture'
  put 'applicants/profile/:type', to: 'applicants#update_profile'

  #dependent
  post 'applicants/dependents', to: 'dependents#create_dependent'
  put 'applicants/dependents/:id', to: 'dependents#update_dependent'
  delete 'applicants/dependents/:id', to: 'dependents#destroy'

  #experiences
  post 'applicants/experiences', to: 'experiences#create_experiences'
  put 'applicants/experiences/:id', to: 'experiences#update_experiences'

  #qualifications
  post 'applicants/qualifications', to: 'qualifications#create_qualifications'
  put 'applicants/qualifications/:id', to: 'qualifications#update_qualifications'

  #licences
  post 'applicants/licences', to: 'licences#create_licences'
  put 'applicants/licences/:id', to: 'licences#update_licences'

  #references
  post 'applicants/references', to: 'references#create_referal'
  put 'applicants/references/:id', to: 'references#update_referal'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
