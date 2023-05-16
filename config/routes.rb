Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root to: "home#index"
  #Rotas
  resources :items, only:[:show,:new, :create]

  resources :winners, controller: 'user_bid_lot', only:[:index]

  resources :lots, only:[:new, :create, :show, :pendents] do
    get 'pendents', on: :collection
    
    get 'finished', on: :collection 
      post 'closed', on: :member
      post 'canceled', on: :member
    
    post 'aprovated', on: :member
    post 'bid', on: :member

    resources :lot_items, only:[:new, :create, :destroy]
    
    resources :questions, only:[:new, :create]
  end

  get '/questions', to: 'questions#index'
end
