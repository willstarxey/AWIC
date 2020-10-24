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
  end

  def show
    @proyecto = Proyecto.find(params[:proyecto_id])
    @proyecto = Proyecto.where(id: @proyecto)
  end

  def store
    #Crea usuario con parámetros de la vista
    @proyecto = Proyecto.new(parametros)
    #Redireccionamiento a la visa de busqueda
    if Proyecto.find_by(nombre: @proyecto.nombre)
      flash[:warning] = "Ya existe un proyecto con el nombre: "+@proyecto.nombre
      redirect_to proyectos_index_path
    elsif @proyecto.save
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
  	else
  		flash[:danger] = "El proyecto no se pudo crear"
      redirect_to proyectos_index_path
    end
  end

  def search
    @proyecto
  end

  #Editar de la vista del administrador de la aplicación
  def edit
    @proyecto = Proyecto.find(params[:id])
    @proyecto = Proyecto.where(id: @proyecto)
    @colab = Colaborador.where(user_id: params[:user_id], proyecto_id: params[:id])
    #Actualizacion de los parametros del proyecto
    if @proyecto.update(parametros)
      @user = @proyecto.first.colaboradors.where(lider: 1).first.user
      if @user.colaboradors.where(lider: 1).length == 1
        update_rol(@proyecto.colaboradors.where(lider: 1).first.user_id, "3")
        #Redireccionamiento a la visa de busqueda
        flash[:success] = "Proyecto Actualizado Correctamente"
        redirect_to proyectos_index_path
      elsif @user.colaboradors.where(lider: 1).length > 1
        #Redireccionamiento a la visa de busqueda
        flash[:success] = "Proyecto Actualizado Correctamente"
        redirect_to proyectos_index_path
      end
      @proyecto.first.colaboradors.where(lider: 1).first.destroy
      if @colab.empty?
        @colaborador = Colaborador.new(user_id: params[:user_id], proyecto_id: params[:id], added_at: Time.now, lider: 1)
        @colaborador.save
        update_rol(params[:user_id], "2")
      else
        @colab.update(lider: 1)
        update_rol(@colab.first.user_id, "2")
      end
    else
      #Redireccionamiento a la visa de busqueda
      flash[:danger] = "No se pudo actualizar el proyecto."
      redirect_to proyectos_index_path
    end
  end

  #Edición del Proyecto con respecto a la vista del Lider del proyecto
  def edit_lider
    @proyecto = Proyecto.find(params[:id])
    @proyecto = Proyecto.where(id: @proyecto)
    if @proyecto.update(parametros_user)
      flash[:success] = "Proyecto Actualizado Correctamente"
      redirect_to dashboard_index_path(:proyecto_id => params[:id])
    else
      #Redireccionamiento a la visa de busqueda
      flash[:danger] = "No se pudo actualizar el proyecto."
      redirect_to proyectos_index_path
    end
  end

  def update
    if params[:proyecto_id]
      @proyecto = Proyecto.find(params[:proyecto_id])
      @proyecto = Proyecto.where(id: @proyecto)
    else
      begin
        @users = User.where.not(role_id: ["1"])
        @proyecto = Proyecto.find(params[:id])
        @proyecto = Proyecto.where(id: @proyecto)
        if !@proyecto.nil?
          @colaboradores = @proyecto.first.colaboradors.where(lider: 1)
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
    #Actualización del Rol del Lider a Usuario
    @user = @proyecto.colaboradors.where(lider: 1).first.user
    if @user.colaboradors.where(lider: 1).length == 1
      update_rol(@user.id, "3")
      #Redireccionamiento a la visa de busqueda
      flash[:success] = "Proyecto Eliminado Correctamente"
      redirect_to proyectos_index_path
    elsif @user.colaboradors.where(lider: 1).length > 1
      #Redireccionamiento a la visa de busqueda
      flash[:success] = "Proyecto Eliminado Correctamente"
      redirect_to proyectos_index_path
    else
      #Redireccionamiento a la visa de busqueda
      flash[:danger] = "No se pudo eliminar el proyecto."
      redirect_to proyectos_index_path
    end
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
