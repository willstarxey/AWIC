class Estrategia::EstimacionesController < ApplicationController
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
    @estimacion = Estrategia::Estimacion.new
  end

  def store
    #Definición e inicialización de nueva Estimacion
    @colaborador = Colaborador.where(proyecto_id: params[:proyecto_id], user_id: current_user.id).first
    @estimacion = Estrategia::Estimacion.new(parametros)
    @estimacion.colaborador_id = @colaborador.id
    if(@estimacion.save)
      #Impresión del proceso satisfactorio
      flash[:success] = "Estimación Creada Correctamente"
      redirect_to estrategia_estimaciones_index_path(:proyecto_id => params[:proyecto_id])
    else
      #Impresión del proceso de error
      flash[:danger] = "No se pudo crear la Estimación"
      redirect_to estrategia_estimaciones_index_path(:proyecto_id => params[:proyecto_id])
    end
  end

  def edit
    @estimacion = Estrategia::Estimacion.find(params[:id])
    @estimacion = Estrategia::Estimacion.where(id: @estimacion).first
    if @estimacion.update(parametros)
      #Impresión del proceso satisfactorio
      flash[:success] = "Estimaciión Actualizada Correctamente"
      redirect_to estrategia_estimaciones_index_path(:proyecto_id => params[:proyecto_id])
    else
      #Impresión del proceso de error
      flash[:danger] = "No se pudo actualizar la estimación"
      redirect_to estrategia_estimaciones_index_path(:proyecto_id => params[:proyecto_id])
    end
  end

  def update
    begin
      @estimacion = Estrategia::Estimacion.find(params[:id])
      @estimacion = Estrategia::Estimacion.where(id: @estimacion)
    rescue ActiveRecord::RecordNotFound => e
      @estimacion = nil
      flash[:danger] = "Estimación No Registrada"
      redirect_to estrategia_estimaciones_index_path(:proyecto_id => params[:proyecto_id])
    end
  end

  def delete
    @estimacion = Estrategia::Estimacion.find(params[:id])
    Estrategia::Estimacion.where(id: @estimacion).destroy_all
    flash[:success] = "Estimación Eliminada"
    redirect_to estrategia_estimaciones_index_path(:proyecto_id => params[:proyecto_id])
  end

  private
  def parametros
    params.permit(:funcion, :descripcion, :tamano, :tiempo, :ciclo)
  end
end
