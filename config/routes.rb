Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'home#index'
  get '/login/', to: 'home#login', as: :login
  get '/logout/', to: 'home#logout', as: :logout
  post '/login/', to: 'google_login#create'

  # Method  |Description
  # index	  |Show all newsletters
  # create	|Create a new newsletter
  # new	    |Render the form for creating a new newsletter
  # edit	  |Render the form for editing a newsletter
  # show	  |Show a single newsletter
  # update	|Update a newsletter
  # destroy	|Delete a newsletter

  resources :users, only: [:show]
  get '/users/', to: redirect('/users/:id')
  get '/users/:id', to: 'users#show'

  resources :events, only: %i[index show]
  resources :tickets, only: %i[show new create]
  resources :artists, only: %i[show]
end
