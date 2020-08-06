Rails.application.routes.draw do
  #mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  root to: "home#index"
  #HOME ROUTES
  get 'home/index'
  get 'home/create'
  #USERS ROUTES
  get 'users/index'
  get 'users/create' => 'users#create'
  get 'users/search'
  get 'users/update' => 'users#update'
  post 'users/store' => 'users#store'
  post 'users/edit/:id', to: 'users#edit'
  post 'users/delete/:id', to: 'users#delete'
  post 'users/restore/:id', to: 'users#restore'
  #PROYECTOS ROUTES
  get 'proyectos/index'
  get 'proyectos/create'
  get 'proyectos/search'
  get 'proyectos/update'
  #DASHBOARD ROUTES
  get 'dashboard/index'
  get 'dashboard/change'
  post 'dashboard/change-password/:id' => 'dashboard#changePass'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
