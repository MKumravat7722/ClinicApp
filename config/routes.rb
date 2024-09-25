Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  resources :patients do
    delete :delete_patient, on: :member
  end
  resources :doctors do
    get 'registrations_chart', on: :member
  end
  get 'patient_registrations', to: 'receptionists#patient_registrations'
  
  resources :receptionists
 

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'doctors#index'

end
