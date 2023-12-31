Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  devise_for :users
  root "users#index"
  resources :users, only: [:index, :show] do
    resources :posts do
      resources :comments,  only: [:new, :create]
      resources :likes,  only: [:create] 
    end
  end
end
