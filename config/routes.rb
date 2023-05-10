Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root to: "home#index"
  #Rotas
  resources :items, only:[:show,:new, :create]

  resources :lots, only:[:new, :create, :show, :pendents] do
    get 'pendents', on: :collection
    get 'finalized', on: :collection
    
    post 'aprovated', on: :member
    post 'bid', on: :member

    resources :lot_items, only:[:new, :create, :destroy]
  end
end
