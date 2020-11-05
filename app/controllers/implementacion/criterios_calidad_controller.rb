class Implementacion::CriteriosCalidadController < ApplicationController
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
    @criterioCalidad = Implementacion::CriterioCalidad.new
  end

  def store
    #Definición e inicialización de nueva Diseno
    @colaborador = Colaborador.where(proyecto_id: params[:proyecto_id], user_id: current_user.id).first
    @criterioCalidad = Implementacion::CriterioCaldidad.new(parametros)
    @criterioCalidad.colaborador_id = @colaborador.id
    if(@criterioCalidad.save)
      #Impresión del proceso satisfactorio
      flash[:success] = "Criterio de Calidad Creado Correctamente"
      redirect_to implementacion_criterios_calidad_estandares_index_path(:proyecto_id => params[:proyecto_id])
    else
      #Impresión del proceso de error
      flash[:danger] = "No se pudo crear el Tipo de Estandar"
      redirect_to implementacion_criterios_calidad_index_path(:proyecto_id => params[:proyecto_id])
    end
  end

  def edit
    @criterioCalidad = Implementacion::CriterioCalidad.find(params[:id])
    @criterioCalidad = Implementacion::CriterioCalidad.where(id: @criterioCalidad).first
    if @criterioCalidad.update(parametros)
      #Impresión del proceso satisfactorio
      flash[:success] = "Criterio de Calidad Actualizado Correctamente"
      redirect_to implementacion_criterios_calidad_index_path(:proyecto_id => params[:proyecto_id])
    else
      #Impresión del proceso de error
      flash[:danger] = "No se pudo actualizar el Criterio de Calidad"
      redirect_to implementacion_criterios_calidad_index_path(:proyecto_id => params[:proyecto_id])
    end
  end

  def update
    begin
      @criterioCalidad = Implementacion::CriterioCalidad.find(params[:id])
      @criterioCalidad = Implementacion::CriterioCalidad.where(id: @criterioCalidad)
    rescue ActiveRecord::RecordNotFound => e
      @tiposEstandares = nil
      flash[:danger] = "Plan de pruebas Eliminada"
      redirect_to diseno_tipos_estandares_index_path(:proyecto_id => params[:proyecto_id])
    end
  end

  def delete
    @criterioCalidad = Implementacion::CriterioCalidad.find(params[:id])
    Implementacion::CriterioCalidad.where(id: @criterioCalidad).destroy_all
    flash[:success] = "Plan de pruebas Eliminado"
    redirect_to implementacion_criterios_calidad_index_path(:proyecto_id => params[:proyecto_id])
  end

  private
  def parametros
    params.permit( :descripcion, :ciclo)
  end
end
