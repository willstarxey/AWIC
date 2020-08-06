class UsersController < ApplicationController
  @root_url = "/users/index"
  layout 'application_dashboard'

  #load_and_authorize_resource

  add_flash_types :notice

  def index
  end
  
  def create
    @user = User.new
  end
  
  def store
    #Crea usuario con parámetros de la vista
    @password = ""
    @user = User.new(parametros)
    @user.password = "AWIC0000"
    #Redireccionamiento a la visa de busqueda
    if @user.save
      flash[:notice] = "Usuario Creado Correctamente"
      redirect_to users_index_path
  	else
  		flash[:notice] = "El usuario no se pudo crear"
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
      flash[:notice] = "Usuario Actualizado Correctamente"
      redirect_to @ini
    end
  
    def update
      begin
        @user = User.find(params[:id])
        @user = User.where(id: @user)
      rescue ActiveRecord::RecordNotFound => e
        @user = nil
        flash[:notice] = "Usuario No Registrado"
        redirect_to users_search_path
      end
    end
  
    def delete
      @user = User.find(params[:id])
      User.where(id: @user).destroy_all
      #Redireccionamiento a la visa de busqueda
      @ini = "/users/index"
      flash[:notice] = "Usuario Eliminado Correctamente"
      redirect_to @ini
    end

    def restore
      @user = User.find(params[:id])
      @user.password = "AWIC0000"
      @user.update(parametros)
      @ini = "/users/index"
      flash[:notice] = "Usuario Restaurado Correctamente"
      redirect_to @ini
    end

  private
  def parametros
    params.permit(:nombre, :app, :apm, :edad, :sexo, :puesto, :email)
  end

end
