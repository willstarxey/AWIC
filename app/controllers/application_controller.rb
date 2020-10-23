class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    #before_action :authenticate_user!
    
    add_flash_types :success, :danger, :info, :warning

    def after_sign_in_path_for(resource)
        dashboard_index_path
    end

    rescue_from CanCan::AccessDenied do
        flash[:danger] = 'Usuario no Autorizado para esta acción'
        redirect_to root_url
    end

end
