Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root to: "home#index"
  #Rotas
  resources :items, only:[:show,:new, :create]

  resources :lots, only:[:new, :create, :show, :pendents] do
    post 'aprovated', on: :member
    get 'pendents', on: :collection

    resources :lot_items, only:[:new, :create, :destroy]
  end
end
