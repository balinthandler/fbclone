Rails.application.routes.draw do
  root 'posts#index'

  devise_for :users
  resources :users
  resources :posts
  resources :comments

  get 'likes/create'
  get 'likes/destroy'

  get 'comments/create'
  get 'comments/destroy'
  
  get 'invitations/create'
  get 'invitations/destroy'
  get 'invitations/update'
  get 'invitations/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
