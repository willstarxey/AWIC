class Planeacion::PlanesCalidadController < ApplicationController

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
    @planCalidad = Planeacion::PlanCalidad.new
  end

  def store
    #Definición e inicialización de nueva PlanCalidad
    @colaborador = Colaborador.where(proyecto_id: params[:proyecto_id], user_id: current_user.id).first
    @planCalidad = Planeacion::PlanCalidad.new(parametros)
    #obteniendo el ciclo del proyecto
    @planCalidad.ciclo = Proyecto.find(params[:proyecto_id]).ciclo_actual
    @planCalidad.colaborador_id = @colaborador.id
    if(@planCalidad.save)
      #Impresión del proceso satisfactorio
      flash[:success] = "Plan de Calidad Creado Correctamente"
    else
      #Impresión del proceso de error
      flash[:danger] = "No se pudo crear el plan de calidad"
    end
      redirect_to planeacion_planes_calidad_index_path(:proyecto_id => params[:proyecto_id])
  end

  def edit
    @planCalidad = Planeacion::PlanCalidad.find(params[:id])
    @planCalidad = Planeacion::PlanCalidad.where(id: @planCalidad).first
    if @planCalidad.update(parametros)
      #Impresión del proceso satisfactorio
      flash[:success] = "Plan de Calidad Actualizado Correctamente"
    else
      #Impresión del proceso satisfactorio
      flash[:danger] = "No se pudo actualizar el plan de calidad"
    end
      redirect_to planeacion_planes_alidad_index_path(:proyecto_id => params[:proyecto_id])
  end

  def update
    begin
      @planCalidad = Planeacion::PlanCalidad.find(params[:id])
      @planCalidad = Planeacion::PlanCalidad.where(id: @planCalidad)
    rescue ActiveRecord::RecordNotFound => e
      @planCalidad = nil
      flash[:danger] = "Plan de Calidad No Registrado"
      redirect_to planeacion_planes_calidad_index_path(:proyecto_id => params[:proyecto_id])
    end
  end

  def delete
    @planCalidad = Planeaciona::PlanCalidad.find(params[:id])
    Planeacion::PlanCalidad.where(id: @planCalidad).destroy_all
    flash[:success] = "Planeacion de Calidad Eliminada"
    redirect_to planeacion_planes_calidads_index_path(:proyecto_id => @planCalidad.colaborador.proyecto_id)
  end

  private
  def parametros
    params.permit(:actividad, :descripcion, :tamano, :tiempo, :ciclo)
  end
end
