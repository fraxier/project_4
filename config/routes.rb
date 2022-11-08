Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'home#index'
  get '/login/', to: 'home#login', as: :login
  get '/logout/', to: 'home#logout', as: :logout
  post '/login/', to: 'google_login#create'

  # Method  |Description
  # index	  |Show all newsletters                           |get
  # create	|Create a new newsletter                        |post
  # new	    |Render the form for creating a new newsletter  |get
  # edit	  |Render the form for editing a newsletter       |get
  # show	  |Show a single newsletter                       |get
  # update	|Update a newsletter                            |put / patch
  # destroy	|Delete a newsletter                            |post

  resources :users, only: %i[show new create] do
    resources :tickets, only: %i[show new create]
  end
  get '/users/', to: 'users#show'
  get '/users/edit/:id', to: 'users#edit'

  resources :events, only: %i[index show]
  resources :artists, only: %i[show index]

  post '/save_event/:id', to: 'home#save_event'
  post '/remove_event/:id', to: 'home#reomve_event'
end
