Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'events/new'
  get 'events/index'
  root 'static_pages#home'

  get '/signup', to: 'users#new'
  get '/', to: 'users#show'
  resources :users, except: [:new, :show]
  resources :events

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :invites, except: [:new, :create]
  get '/send_invite/:id', to: 'invites#new'
  post '/send_invite/:id', to: 'invites#create'
end
