Rails.application.routes.draw do
 
  devise_for :models
  devise_for :users
  devise_scope :user do
    authenticated :user do
      root :to => 'pages#home'
    end
    unauthenticated :user do
      root :to => 'devise/registrations#new', as: :unauthenticated_root
    end
  end
  resources :users do
    resource :profile
    resource :post
  end
  
  
  get '/search' => 'pages#search', :as => 'search_page'
end