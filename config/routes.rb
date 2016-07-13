Rails.application.routes.draw do
  root 'static_pages#home'
  get '/help', to: 'static_pages#help'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/mail/inbox', to: 'messages#inbox'
  get '/mail/sent', to: 'messages#sent'
  resources :exchanges do
    member do
      post :invite_send, to: 'exchanges#invite_send'
      post :invite_accept, to: 'exchanges#invite_accept'
      get :invite_all, to: 'exchanges#invite_all'
      get :raffle, to: 'exchanges#raffle'
      get :reveal, to: 'exchanges#reveal'
    end
  end
  resources :groups do
    member do
      post :invite_send, to: 'groups#invite_send'
      post :invite_accept, to: 'groups#invite_accept'
    end
  end
  resources :users
  resources :account_activations, only: [:edit]
  resources :messages
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end