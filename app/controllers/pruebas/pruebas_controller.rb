class Pruebas::PruebasController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  layout 'application_dashboard'

  def index
    begin
      @proyecto = Proyecto.find(params[:proyecto_id])
      @colaboradors = nil
      @colaboradors = Colaborador.where(proyecto_id: params[:proyecto_id])
    rescue ActiveRecord::RecordNotFound => e
      flash[:danger] = "No se ha seleccionado el proyecto"
      redirect_to dashboard_index_path
    end
  end

  def create
    @colaboradors = Colaborador.where(proyecto_id: params[:proyecto_id])
    @prueba = Pruebas::Prueba.new
  end

  def store
    #Definición e inicialización de nueva Prueba
    @colaborador = Colaborador.where(proyecto_id: params[:proyecto_id], user_id: current_user.id).first
    @prueba = Pruebas::Prueba.new(parametros)
    @prueba.colaborador_id = @colaborador.id
    @prueba.lanzamiento_metas = Lanzamiento::Meta.find(params[:lanzamiento_metas_ids]).to_json
    @prueba.estrategia_disenos = Estrategia::Diseno.find(params[:estrategia_disenos_ids]).to_json
    @prueba.estrategia_criterios = Estrategia::Criterio.find(params[:estrategia_criterios_ids]).to_json
    @prueba.estrategia_estimaciones = Estrategia::Estimacion.find(params[:estrategia_estimaciones_ids]).to_json
    @prueba.planeacion_planes_calidad = Planeacion::PlanCalidad.find(params[:planeacion_planes_calidad_ids]).to_json
    @prueba.requerimientos = Requerimientos::Requerimiento.find(params[:requerimientos_requerimientos_ids]).to_json
    @prueba.diseno_estructuras = Diseno::Estructura.find(params[:diseno_estructuras_ids]).to_json
    @prueba.diseno_planes_pruebas = Diseno::PlanPruebas.find(params[:diseno_planes_pruebas_ids]).to_json
    #@prueba.diseno_estandares = Diseno::Estandar.find(params[:diseno_estandares_ids]).to_json
    @prueba.implementacion_criterios_calidad = Implementacion::CriterioCalidad.find(params[:implementacion_criterios_calidad_ids]).to_json
    if(@prueba.save)
      #Impresión del proceso satisfactorio
      flash[:success] = "Prueba Creada Correctamente"
    else
      #Impresión del proceso de error
      flash[:danger] = "No se pudo crear la Prueba"
    end
    redirect_to pruebas_pruebas_index_path(:proyecto_id => params[:proyecto_id])
  end

  def edit
    @prueba = Pruebas::Prueba.find(params[:id])
    @prueba = Pruebas::Prueba.where(id: @prueba).first
    @prueba.lanzamiento_metas = Lanzamiento::Meta.find(params[:lanzamiento_metas_ids]).to_json
    @prueba.estrategia_disenos = Estrategia::Diseno.find(params[:estrategia_disenos_ids]).to_json
    @prueba.estrategia_criterios = Estrategia::Criterio.find(params[:estrategia_criterios_ids]).to_json
    @prueba.estrategia_estimaciones = Estrategia::Estimacion.find(params[:estrategia_estimaciones_ids]).to_json
    @prueba.planeacion_planes_calidad = Planeacion::PlanCalidad.find(params[:planeacion_planes_calidad_ids]).to_json
    @prueba.requerimientos = Requerimientos::Requerimiento.find(params[:requerimientos_requerimientos_ids]).to_json
    @prueba.diseno_estructuras = Diseno::Estructura.find(params[:diseno_estructuras_ids]).to_json
    @prueba.diseno_planes_pruebas = Diseno::PlanPruebas.find(params[:diseno_planes_pruebas_ids]).to_json
    @prueba.diseno_estandares = Diseno::Estandares.find(params[:diseno_estandares_ids]).to_json
    @prueba.implementacion_planes_calidad = Implementacion::PlanCalidad.find(params[:implementacion_planes_calidad_ids]).to_json
    if @prueba.update(parametros)
      #Impresión del proceso satisfactorio
      flash[:success] = "Prueba Actualizada Correctamente"
    else
      #Impresión del proceso de error
      flash[:danger] = "No se pudo actualizar la Prueba"
    end
    redirect_to pruebas_pruebas_index_path(:proyecto_id => params[:proyecto_id])
  end

  def update
    begin
      @prueba = Pruebas::Prueba.find(params[:id])
      @prueba = Pruebas::Prueba.where(id: @prueba)
      @colaboradors = Colaborador.where(proyecto_id: params[:proyecto_id])
    rescue ActiveRecord::RecordNotFound => e
      @prueba = nil
      flash[:danger] = "Prueba No Registrada"
      redirect_to pruebas_pruebas_index_path(:proyecto_id => params[:proyecto_id])
    end
  end

  def delete
    @prueba = Pruebas::Prueba.find(params[:id])
    Pruebas::Prueba.where(id: @prueba).destroy_all
    flash[:success] = "Prueba Eliminada"
    redirect_to pruebas_pruebas_index_path(:proyecto_id => params[:proyecto_id])
  end

  private
  def parametros
    params.permit(:nombre, :descripcion, :entrada, :r_obtenido, :r_deseado, :cunmple, :ciclo,
      :lanzamiento_metas_ids,:estrategia_disenos_ids,:estrategia_criterios_ids,:estrategia_estimaciones_ids,:planeacion_planes_calidad_ids,
      :requerimientos_requerimientos_ids,:diseno_estructuras_ids,:diseno_planes_pruebas_ids,:diseno_estandares_ids,:implementacion_planes_calidad_ids)
  end

end
