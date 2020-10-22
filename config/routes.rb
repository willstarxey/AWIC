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
    post 'proyectos/edit_lider/:id', to: 'proyectos#edit_lider'
    post 'proyectos/delete/:id', to: 'proyectos#delete'
    #DASHBOARD ROUTES
    get 'dashboard/index'
    get 'dashboard/change'
    post 'dashboard/change-password/:id' => 'dashboard#changePass'
    #ERROR ROUTES
    get "/404", to: "errors#not_found"
    get "/422", to: "errors#unacceptable"
    get "/500", to: "errors#internal_error"

    #RUTAS PARA METODOLOGÍA TSP
    namespace :lanzamiento do
      #LANZAMIENTO::PERSONAL
      get 'personal/index'
      get 'personal/add' => 'personal#add'
      post 'personal/store' => 'personal#store'
      post 'personal/delete/:id', to: 'personal#delete'
      #LANZAMIENTO::METAS
      get 'metas/index'
      get 'metas/create' => 'metas#create'
      get 'metas/update' => 'metas#update'
      post 'metas/store' => 'metas#store'
      post 'metas/edit/:id', to: 'metas#edit'
      post 'metas/delete/:id', to: 'metas#delete'
    end
    namespace :planeacion do
      #PLANEACION::PLANES_DE_CALIDAD
      get 'planes_calidad/index'
      get 'planes_calidad/create' => 'planes_calidad#create'
      get 'planes_calidad/update' => 'planes_calidad#update'
      post 'planes_calidad/store' => 'planes_calidad#store'
      post 'planes_calidad/edit/:id', to: 'planes_calidad#edit'
      post 'planes_calidad/delete/:id', to: 'planes_calidad#delete'
    end
    namespace :estrategia do
      #ESTRATEGIA::CRITERIOS
      get 'criterios/index'
      get 'criterios/create' => 'criterios#create'
      get 'criterios/update' => 'criterios#create'
      post 'criterios/store' => 'criterios#store'
      post 'criterios/edit/:id', to: 'criterios#edit'
      post 'criterios/delete/:id', to: 'criterios#delete'
      #ESTRATEGIA::DISEÑOS
      get 'disenos/index'
      get 'disenos/create' => 'disenos#create'
      get 'disenos/update' => 'disenos#create'
      post 'disenos/store' => 'disenos#store'
      post 'disenos/edit/:id', to: 'disenos#edit'
      post 'disenos/delete/:id', to: 'disenos#delete'
    end
    namespace :requerimientos do
      #REQUERIMIENTOS::REQUERIMIENTOS
      get 'requerimientos/index'
      get 'requerimientos/create' => 'requerimientos#create'
      get 'requerimientos/update' => 'requerimientos#create'
      post 'requerimientos/store' => 'requerimientos#store'
      post 'requerimientos/edit/:id', to: 'requerimientos#edit'
      post 'requerimientos/delete/:id', to: 'requerimientos#delete'
    end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
