Rails.application.routes.draw do
  devise_for :guests, controllers: { 
    sessions: 'guests/sessions', 
    registrations: 'guests/registrations'
  }
  devise_for :hosts, controllers: { 
    sessions: 'hosts/sessions',
    registrations: 'hosts/registrations' 
  }
  
  root to: 'home#index'

  resources :searches
  resources :guesthouses, except: [:destroy] do
    post 'active', on: :member
    post 'inactive', on: :member
    get 'cities', on: :collection
    get 'search', on: :collection
    
    resources :rooms, except: [:destroy] do
      post 'active', on: :member
      post 'inactive', on: :member
      get 'availability', on: :member
      resources :custom_prices, except: [:destroy]
      resources :bookings, except: [:destroy] 
    end
  end
  get 'my_bookings', to: 'bookings#my_bookings'
end