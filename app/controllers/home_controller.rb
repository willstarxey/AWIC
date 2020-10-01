class HomeController < ApplicationController

  #load_and_authorize_resource class: "User", except: [:index, :create]
  #skip_authorize_resource :only => [:index, :create]
  #skip_authorize_resource :only => [:index, :create]
  
  layout 'application'

  add_flash_types :success, :danger, :info, :warning

  def index
    @userAdmin = User.find_by role_id: '1'
    if @userAdmin.nil?
      flash[:warning] = "No existe administrador, favor de crearlo."
      redirect_to home_create_path
    end
  end

  def create
    @userAdmin = User.find_by role_id: '1'
    if !@userAdmin.nil?
      redirect_to dashboard_index_path
    else
      @user = User.new
    end
  end
  
  def store
    #Crea usuario con parámetros de la vista
    @user = User.new(parametros)
    #Asgnación del Rol de administrador
    @admin = Role.find_by nombre: 'Administrador'
    @user.role_id = @admin.id
    #Confirmación del match de las contraseñas
    if params[:password] != params[:confirmPass]
      @ini = "/home/create"
      flash[:warning] = "Las Contraseñas No Coinciden"
      redirect_to @ini
    else
      if @user.save
        flash[:success] = "Administrador Creado Correctamente"
        redirect_to dashboard_index_path
      else
        flash[:danger] = "El Administrador no se pudo crear"
        redirect_to home_create_path
      end
    end
  end

  private
  def parametros
    params.permit(:nombre, :app, :apm, :edad, :sexo, :puesto, :email, :password)
  end

end
