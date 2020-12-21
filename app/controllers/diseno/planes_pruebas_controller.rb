class Diseno::PlanesPruebasController < ApplicationController
  
  before_action :authenticate_user!
  load_and_authorize_resource :class => Diseno::PlanPruebas

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
    @planPruebas = Diseno::PlanPruebas.new
  end

  def store
    #Definición e inicialización de nueva Diseno
    @colaborador = Colaborador.where(proyecto_id: params[:proyecto_id], user_id: current_user.id).first
    @planPruebas = Diseno::PlanPruebas.new(parametros)
    #obteniendo el ciclo del proyecto
    @planPruebas.ciclo = Proyecto.find(params[:proyecto_id]).ciclo_actual
    @planPruebas.colaborador_id = @colaborador.id
    if(@planPruebas.save)
      #Impresión del proceso satisfactorio
      flash[:success] = "Plan de pruebas Creado Correctamente"
    else
      #Impresión del proceso satisfactorio
      flash[:danger] = "No se pudo crear la Plan de pruebas"
    end
    redirect_to diseno_planes_pruebas_index_path(:proyecto_id => params[:proyecto_id])
  end

  def edit
    @planPruebas = Diseno::PlanPruebas.find(params[:id])
    @planPruebas = Diseno::PlanPruebas.where(id: @planPruebas).first
    if @planPruebas.update(parametros)
      #Impresión del proceso satisfactorio
      flash[:success] = "Plan de Pruebas Actualizado Correctamente"
    else
      #Impresión del proceso satisfactorio
      flash[:danger] = "Plan de pruebas actualiza la estimación"
    end
      redirect_to diseno_planes_pruebas_index_path(:proyecto_id => params[:proyecto_id])
  end

  def update
    begin
      @planPruebas = Diseno::PlanPruebas.find(params[:id])
      @planPruebas = Diseno::PlanPruebas.where(id: @planPruebas)
    rescue ActiveRecord::RecordNotFound => e
      @planPruebas = nil
      flash[:danger] = "Plan de pruebas no encontrado"
      redirect_to diseno_planes_pruebas_index_path(:proyecto_id => params[:proyecto_id])
    end
  end

  def delete
    @planPruebas = Diseno::PlanPruebas.find(params[:id])
    Diseno::PlanPruebas.where(id: @planPruebas).destroy_all
    flash[:success] = "Plan de Pruebas Eliminado"
    redirect_to diseno_planes_pruebas_index_path(:proyecto_id => params[:proyecto_id])
  end

  private
  def parametros
    params.permit( :nombre, :descripcion, :ciclo)
  end
end
