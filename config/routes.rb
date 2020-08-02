Rails.application.routes.draw do
  get 'dashboard/index'
  devise_for :users
  root to: "home#index"
  get 'home/index'
  get 'home/create'
  get 'users/index'
  get 'users/create'
  get 'users/search'
  get 'users/update'
  get 'user/index'
  get 'user/create'
  get 'user/search'
  get 'user/update'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
