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
      get 'criterios/update' => 'criterios#update'
      post 'criterios/store' => 'criterios#store'
      post 'criterios/edit/:id', to: 'criterios#edit'
      post 'criterios/delete/:id', to: 'criterios#delete'
      #ESTRATEGIA::DISEÑOS
      get 'disenos/index'
      get 'disenos/create' => 'disenos#create'
      get 'disenos/update' => 'disenos#update'
      post 'disenos/store' => 'disenos#store'
      post 'disenos/edit/:id', to: 'disenos#edit'
      post 'disenos/delete/:id', to: 'disenos#delete'
      #ESTRATEGIA::ESTIMACIONES
      get 'estimaciones/index'
      get 'estimaciones/create'
      get 'estimaciones/update'
      post 'estimaciones/store' => 'estimaciones#store'
      post 'estimaciones/edit/:id', to: 'estimaciones#edit'
      post 'estimaciones/delete/:id', to: 'estimaciones#delete'
    end
    namespace :requerimientos do
      #REQUERIMIENTOS::REQUERIMIENTOS
      get 'requerimientos/index'
      get 'requerimientos/create' => 'requerimientos#create'
      get 'requerimientos/update' => 'requerimientos#update'
      post 'requerimientos/store' => 'requerimientos#store'
      post 'requerimientos/edit/:id', to: 'requerimientos#edit'
      post 'requerimientos/delete/:id', to: 'requerimientos#delete'
    end
    namespace :postmortem do
      #POSTMORTEM::RESUMENES
      get 'resumenes/index'
      get 'resumenes/create' => 'resumenes#create'
      get 'resumenes/update' => 'resumenes#update'
      post 'resumenes/store' => 'resumenes#store'
      post 'resumenes/edit/:id', to: 'resumenes#edit'
      post 'resumenes/delete/:id', to: 'resumenes#delete'
    end
    namespace :pruebas do
      #PRUEBAS::PRUEBAS
      get 'pruebas/index'
      get 'pruebas/create'
      get 'pruebas/update'
      post 'pruebas/store' => 'pruebas#store'
      post 'pruebas/edit/:id', to: 'pruebas#edit'
      post 'pruebas/delete/:id', to: 'pruebas#delete'
    end
    namespace :implementacion do
      get 'criterios_calidad/index'
      get 'criterios_calidad/create'
      get 'criterios_calidad/update'
      post 'criterios_calidad/store' => 'criterios_calidad#store'
      post 'criterios_calidad/edit/:id', to: 'criterios_calidad#edit'
      post 'criterios_calidad/delete/:id', to: 'criterios_calidad#delete'
    end
    namespace :diseno do
      #DISENO::TIPOS_ESTANDARES
      get 'tipos_estandares/index'
      get 'tipos_estandares/create'
      get 'tipos_estandares/update'
      post 'tipos_estandares/store' => 'tipos_estandares#store'
      post 'tipos_estandares/edit/:id', to: 'tipos_estandares#edit'
      post 'tipos_estandares/delete/:id', to: 'tipos_estandares#delete'
      #DISENO::ESTANDARES
      get 'estandares/index'
      get 'estandares/create'
      get 'estandares/update'
      post 'estandares/store' => 'estandares#store'
      post 'estandares/edit/:id', to: 'estandares#edit'
      post 'estandares/delete/:id', to: 'estandares#delete'
      #DISENO::PLANES_PRUEBAS
      get 'planes_pruebas/index'
      get 'planes_pruebas/create'
      get 'planes_pruebas/update'
      post 'planes_pruebas/store' => 'planes_pruebas#store'
      post 'planes_pruebas/edit/:id', to: 'planes_pruebas#edit'
      post 'planes_pruebas/delete/:id', to: 'planes_pruebas#delete'
      #DISENO::ESTRUCUTURAS
      get 'estructuras/index'
      get 'estructuras/create'
      get 'estructuras/update'
      post 'estructuras/store' => 'estructuras#store'
      post 'estructuras/edit/:id', to: 'estructuras#edit'
      post 'estructuras/delete/:id', to: 'estructuras#delete'
    end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
