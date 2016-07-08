Rails.application.routes.draw do
  root  'static_pages#home'
  get   '/help',    to: 'static_pages#help'
  get   '/about',   to: 'static_pages#about'
  get   '/contact', to: 'static_pages#contact'
  get   '/signup',  to: 'users#new'
  get    '/login',  to: 'sessions#new'
  post   '/login',  to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :exchanges do
    member do
      post :invite_send, to: 'exchanges#invite_send'
      post :invite_accept, to: 'exchanges#invite_accept'
      get :raffle, to: 'exchanges#raffle'
      get :reveal, to: 'exchanges#reveal'
   end
  end
  resources :groups do
    member do
      post :invite_all, to: 'groups#invite_all'
    end
end
  resources :users
  resources :account_activations, only: [:edit]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end