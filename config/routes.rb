Rails.application.routes.draw do
  devise_for :users
  get 'users/new'
#  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
 # devise_for :users
 # get 'users/new'

mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root                'home#index'
  #Static Routes
  get    'about'   => 'home#about'
  get    'contact' => 'home#contact'
  get    'credits' => 'home#credits'
  
  #Photography routes
  get    'photography' => 'photography#index'
  get    'albums' => 'photography#albums'
  get    'album/:id' => 'photography#album'
  get    'pictures' => 'photography#pictures'
  
  #Contact routes
post 'contact', to: 'home#submit_email'


  resources :users
end

