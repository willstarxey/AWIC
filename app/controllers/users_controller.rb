class UsersController < ApplicationController

  before_action :authenticate_user!
  load_and_authorize_resource

  @root_url = "/users/index"
  layout 'application_dashboard'

  add_flash_types :success, :danger, :info, :warning

  def index
  end
  
  def create
    @user = User.new
  end
  
  def store
    #Crea usuario con parámetros de la vista
    @user = User.new(parametros)
    @user.password = "AWIC0000"
    #Redireccionamiento a la visa de busqueda
    if @user.save
      flash[:success] = "Usuario Creado Correctamente"
      redirect_to users_index_path
    elsif User.find_by(email: @user.email)
      flash[:warning] = "Ya existe un usuario con el correo: "+@user.email
      redirect_to users_index_path
  	else
  		flash[:danger] = "El usuario no se pudo crear"
      redirect_to users_index_path
    end
  end
  
    #Buscar un usuario por ID y ver sus datos
    def search
      @user
    end
  
    def edit
      @user = User.find(params[:id])
      @user = User.where(id: @user)
      @user.update(parametros)
      #Redireccionamiento a la visa de busqueda
      @ini = "/users/index"
      flash[:success] = "Usuario Actualizado Correctamente"
      redirect_to @ini
    end
  
    def update
      begin
        @user = User.find(params[:id])
        @user = User.where(id: @user)
      rescue ActiveRecord::RecordNotFound => e
        @user = nil
        flash[:danger] = "Usuario No Registrado"
        redirect_to users_search_path
      end
    end
  
    def delete
      @user = User.find(params[:id])
      if Proyecto.find_by(user_id: @user.id)
        flash[:danger] = "No se pudo eliminar el usuario porque lidera un proyecto, favor de removerlo de su cargo primero."
        redirect_to users_index_path
      else
        User.where(id: @user).destroy_all
        #Redireccionamiento a la visa de busqueda
        flash[:success] = "Usuario Eliminado Correctamente"
        redirect_to users_index_path
      end
    end

    def restore
      @user = User.find(params[:id])
      @user.password = "AWIC0000"
      if @user.update(parametros)
        flash[:success] = "Usuario Restaurado Correctamente"
        redirect_to users_index_path
      else
        flash[:success] = "El usuario no se pudo restaurar correctamente."
        redirect_to users_index_path
      end
    end

  private
  def parametros
    params.permit(:nombre, :app, :apm, :edad, :sexo, :puesto, :email, :role_id)
  end
end
