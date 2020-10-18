class ProyectosController < ApplicationController

  before_action :authenticate_user!
  #load_and_authorize_resource
  
  @root_url = "/proyectos/index"
  layout 'application_dashboard'

  add_flash_types :success, :danger, :info, :warning
  
  def index
  end

  def create
    @proyecto = Proyecto.new
  end

  def show
    @proyecto = Proyecto.find(params[:proyecto_id])
    @proyecto = Proyecto.where(id: @proyecto)
  end

  def store
    #Crea usuario con parámetros de la vista
    @proyecto = Proyecto.new(parametros)
    #Redireccionamiento a la visa de busqueda
    if @proyecto.save
      #Actualización del Rol del Usuario a Lider
      @user = User.find(params[:user_id])
      @user = User.where(id: @user)
      @user.update(role_id: Role.find("2").id)
      #Añadiendo a la relación muchos a muchos
      @colab = Colaborador.new(user_id: params[:user_id], proyecto_id: @proyecto.id, added_at: Time.now, lider: 1)
      @colab.save
      #Impresión del proceso satisfactorio
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
    @user_project = Colaborador.where(lider: true, proyecto_id: params[:id]).first
    #Actualiza el proyecto
    if @proyecto.update(parametros)
      update_rol(@user_project.user_id, "3")
      update_rol(params[:user_id], "2")
      @user_project.update(user_id: params[:user_id], added_at: Time.now, lider: 1)
      #Redireccionamiento a la visa de busqueda
      flash[:success] = "Proyecto Actualizado Correctamente"
      redirect_to proyectos_index_path
    end
  end

  def edit_lider
    @proyecto = Proyecto.find(params[:id])
    @proyecto = Proyecto.where(id: @proyecto)
    if @proyecto.update(parametros_user)
      flash[:success] = "Proyecto Actualizado Correctamente"
      redirect_to dashboard_index_path(:proyecto_id => params[:id])
    end
  end

  def update
    if params[:proyecto_id]
      @proyecto = Proyecto.find(params[:proyecto_id])
      @proyecto = Proyecto.where(id: @proyecto)
    else
    begin
      @proyecto = Proyecto.find(params[:id])
      @proyecto = Proyecto.where(id: @proyecto)
      if !@proyecto.nil?
        @colaboradores = Colaborador.where(lider: true, proyecto_id: params[:id])
        @lider = @colaboradores.first.user_id
      end
    rescue ActiveRecord::RecordNotFound => e
      @proyecto = nil
      flash[:danger] = "Proyecto No Registrado"
      redirect_to proyectos_search_path
    end
  end
  end

  def delete
    @proyecto = Proyecto.find(params[:id])
    Proyecto.where(id: @proyecto).destroy_all
    #Actualización del Rol del Usuario a Lider
    @user = User.find(params[:user_id])
    @user = User.where(id: @user)
    if !@user.proyectos.lider?
      @user.update(role_id: Role.find("3").id)
    end
    #Impresión del proceso satisfactorio
    #Redireccionamiento a la visa de busqueda
    flash[:success] = "Proyecto Eliminado Correctamente"
    redirect_to proyectos_index_path
  end

  private
  def parametros
    params.permit(:nombre)
  end

  def parametros_user
    params.permit(:nombre, :descripcion, :n_ciclos)
  end

  #Actualización de roles a usuarios
  def update_rol(user_id, rol)
    @user = User.find(user_id)
    @user = User.where(id: @user)
    @user.update(role_id: Role.find(rol).id)
  end

end
