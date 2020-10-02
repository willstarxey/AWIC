class ProyectosController < ApplicationController

  before_action :authenticate_user!
  load_and_authorize_resource
  
  @root_url = "/proyectos/index"
  layout 'application_dashboard'

  add_flash_types :success, :danger, :info, :warning
  
  def index
  end

  def create
    @proyecto = Proyecto.new
    @users = getUsers()
  end

  def store
    #Crea usuario con parámetros de la vista
    @proyecto = Proyecto.new(parametros)
    #Redireccionamiento a la visa de busqueda
    if @proyecto.save
      flash[:success] = "Proyecto Creado Correctamente"
      redirect_to proyectos_index_path
    elsif Proyecto.find_by(nombre: @proyecto.nombre)
      flash[:warning] = "Ya existe un proyecto con el nombre: "+@proyecto.nombre
      redirect_to proyectos_index_path
  	else
  		flash[:danger] = "El proyecto no se pudo crear"
      redirect_to proyectos_index_path
    end
  end

  def search
    @proyecto
  end

  def edit
    @proyecto = Proyecto.find(params[:id])
    @proyecto = Proyecto.where(id: @proyecto)
    @proyecto.update(parametros)
    #Redireccionamiento a la visa de busqueda
    flash[:success] = "Proyecto Actualizado Correctamente"
    redirect_to proyectos_index_path
  end

  def update
    begin
      @proyecto = Proyecto.find(params[:id])
      @proyecto = Proyecto.where(id: @proyecto)
      @users = getUsers()
    rescue ActiveRecord::RecordNotFound => e
      @proyecto = nil
      flash[:danger] = "Proyecto No Registrado"
      redirect_to proyectos_search_path
    end
  end

  def delete
    @proyecto = Proyecto.find(params[:id])
    Proyecto.where(id: @proyecto).destroy_all
    #Redireccionamiento a la visa de busqueda
    flash[:success] = "Proyecto Eliminado Correctamente"
    redirect_to proyectos_index_path
  end

  private
  def parametros
    params.permit(:nombre, :user_id)
  end

  def getUsers
    @user = nil
    return @users = User.all
  end

end
