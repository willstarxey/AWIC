class Requerimientos::RequerimientosController < ApplicationController

  before_action :authenticate_user!
  load_and_authorize_resource

  layout 'application_dashboard'

  def index
    begin
      @proyecto = Proyecto.find(params[:proyecto_id])
      @colaboradors = nil
      if current_user.role_id == 2
        @colaboradors = Colaborador.where(proyecto_id: params[:proyecto_id])
      else
        @colaboradors = Colaborador.where(proyecto_id: params[:proyecto_id], user_id: current_user.id)
      end
    rescue ActiveRecord::RecordNotFound => e
      flash[:danger] = "No se ha seleccionado el proyecto"
      redirect_to dashboard_index_path
    end
  end

  def create
    @requerimiento = Requerimientos::Requerimiento.new
  end

  def store
    #Definición e inicialización de nueva Requerimientos
    @colaborador = Colaborador.where(proyecto_id: params[:proyecto_id], user_id: current_user.id).first
    @requerimiento = Requerimientos::Requerimiento.new(parametros)
    @requerimiento.colaborador_id = @colaborador.id
    if(@requerimiento.save)
      #Impresión del proceso satisfactorio
      flash[:success] = "Requerimiento Creado Correctamente"
      redirect_to requerimientos_requerimientos_index_path(:proyecto_id => params[:proyecto_id])
    else
      #Impresión del proceso de error
      flash[:danger] = "No se pudo crear el Requerimiento"
      redirect_to requerimientos_requerimientos_index_path(:proyecto_id => params[:proyecto_id])
    end
  end

  def edit
    @requerimiento = Requerimientos::Requerimiento.find(params[:id])
    @requerimiento = Requerimientos::Requerimiento.where(id: @requerimiento).first
    if @requerimiento.update(parametros)
      #Impresión del proceso satisfactorio
      flash[:success] = "Requerimiento Actualizado Correctamente"
      redirect_to requerimientos_requerimientos_index_path(:proyecto_id => params[:proyecto_id])
    else
      #Impresión del proceso de error
      flash[:danger] = "Requerimiento actualiza la estimación"
      redirect_to requerimientos_requerimientos_index_path(:proyecto_id => params[:proyecto_id])
    end
  end

  def update
    begin
      @requerimiento = Requerimientos::Requerimiento.find(params[:id])
      @requerimiento = Requerimientos::Requerimiento.where(id: @requerimiento)
    rescue ActiveRecord::RecordNotFound => e
      @requerimiento = nil
      flash[:danger] = "Requerimiento No Existe"
      redirect_to requerimientos_requerimientos_index_path(:proyecto_id => params[:proyecto_id])
    end
  end

  def delete
    @requerimiento = Requerimientos::Requerimiento.find(params[:id])
    Requerimientos::Requerimiento.where(id: @requerimiento).destroy_all
    flash[:success] = "Requerimiento Eliminado"
    redirect_to requerimientos_requerimientos_index_path(:proyecto_id => params[:proyecto_id])
  end

  private
  def parametros
    params.permit(:descripcion, :fuente, :tipo, :tamano, :ambiente, :restricciones, :procesos, :tiempo, :ciclo)
  end
end
