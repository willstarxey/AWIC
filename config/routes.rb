Rails.application.routes.draw do
  devise_for :users , :skip => [:registrations]
  devise_scope :user do  
    delete '/users/sign_out' => 'devise/sessions#destroy'     
  end
  root to: "home#index"
  #HOME ROUTES
  get 'home/index'
  get 'home/create' => 'home#create'
  post 'home/store' => 'home#store'

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
    get 'proyectos/create' => 'proyectos#create'
    get 'proyectos/search'
    get 'proyectos/update' => 'proyectos#update'
    post 'proyectos/store' => 'proyectos#store'
    post 'proyectos/edit/:id', to: 'proyectos#edit'
    post 'proyectos/delete/:id', to: 'proyectos#delete'
    #DASHBOARD ROUTES
    get 'dashboard/index'
    get 'dashboard/change'
    post 'dashboard/change-password/:id' => 'dashboard#changePass'
    #ERROR ROUTES
    get "/404", to: "errors#not_found"
    get "/422", to: "errors#unacceptable"
    get "/500", to: "errors#internal_error"

    #LANZAMIENTO::METAS
    namespace :lanzamiento do
      get 'metas/index'
      get 'metas/create' => 'metas#create'
      get 'metas/update' => 'metas#update'
      post 'metas/store' => 'metas#store'
      post 'metas/edit/:id', to: 'metas#edit'
      post 'metas/delete/:id', to: 'metas#delete'
    end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
