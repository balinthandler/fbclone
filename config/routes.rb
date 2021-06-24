Rails.application.routes.draw do
  root 'posts#index'

  devise_for :users
  resources :users
  
  get 'invitations/create'
  get 'invitations/destroy'
  get 'invitations/update'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
