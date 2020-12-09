class Postmortem::ResumenesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  layout 'application_dashboard'

  def index
    begin
      @proyecto = Proyecto.find(params[:proyecto_id])
    rescue ActiveRecord::RecordNotFound => e
      flash[:danger] = "No se ha seleccionado el proyecto"
      redirect_to dashboard_index_path
    end
  end

  def create
    @resumen = Postmortem::Resumen.new
    @proyecto = Proyecto.find(params[:proyecto_id])
  end

  def store
    #Definición e inicialización de nuevo resumen del postmortem
    @resumen = Postmortem::Resumen.new(parametros)
    if(@resumen.ciclo == "0")
      flash[:warning] = "El ciclo no se seleccionó o no se ha establecido el número de ciclos"
    else
      @match_resumen = match_pruebas(params[:proyecto_id], params[:ciclo])
      @resumen.lanzamiento_metas = @match_resumen[0]
      @resumen.estrategia_disenos = @match_resumen[1]
      @resumen.estrategia_criterios = @match_resumen[2]
      @resumen.estrategia_estimaciones = @match_resumen[3]
      @resumen.planeacion_planes_calidad = @match_resumen[4]
      @resumen.requerimientos_requerimientos = @match_resumen[5]
      @resumen.diseno_estructuras = @match_resumen[6]
      @resumen.diseno_planes_pruebas = @match_resumen[7]
      @resumen.diseno_estandares = @match_resumen[8]
      @resumen.implementacion_criterios_calidad = @match_resumen[9]
      if(@resumen.save)
        #Impresión del proceso satisfactorio
        flash[:success] = "Resumen Creado Correctamente"
      else
        #Impresión del proceso de error
        flash[:danger] = "No se pudo crear el Resumen"
      end
    end
    redirect_to postmortem_resumenes_index_path(:proyecto_id => params[:proyecto_id])
  end

  def edit
    @resumen = Postmortem::Resumen.find(params[:id])
    @resumen = Postmortem::Resumen.where(id: @resumen).first
    if @resumen.update(parametros)
      #Impresión del proceso satisfactorio
      flash[:success] = "Resumen Actualizado Correctamente"
    else
      #Impresión del proceso de error
      flash[:danger] = "Resumen actualiza la estimación"
    end
    redirect_to postmortem_resumenes_index_path(:proyecto_id => params[:proyecto_id])
  end

  def update
    begin
      @resumen = Postmortem::Resumen.find(params[:id])
      @resumen = Postmortem::Resumen.where(id: @resumen)
    rescue ActiveRecord::RecordNotFound => e
      @resumen = nil
      flash[:danger] = "Resumen No Existe"
      redirect_to postmortem_resumen_index_path(:proyecto_id => params[:proyecto_id])
    end
  end

  def update_ciclo_proyecto
    @proyecto = Proyecto.find(params[:proyecto_id])
    @proyecto = Proyecto.where(id: @proyecto).first
    @ciclo_actual = @proyecto.ciclo_actual+1
    @proyecto.ciclo_actual = @ciclo_actual
    if @proyecto.update(ciclo_actual: @ciclo_actual)
      flash[:success] = "Proyecto Actualizado al Siguiente Ciclo"
    else
      flash[:danger] = "No Se Pudo Actualizar El Ciclo"
    end
    redirect_to postmortem_resumenes_index_path(:proyecto_id => params[:proyecto_id])
  end

  def end_proyecto
    @proyecto = Proyecto.find(params[:proyecto_id])
    @proyecto = Proyecto.where(id: @proyecto).first
    @ciclo_final = @proyecto.n_ciclos
    if @proyecto.update(ciclo_actual: @ciclo_final, finalizado: true)
      flash[:success] = "Proyecto Finalizado"
    else
      flash[:danger] = "No Se Pudo Finalizar el Proyecto"
    end
    redirect_to postmortem_resumenes_index_path(:proyecto_id => params[:proyecto_id])
  end

  #Método para matchear todos los procesos incluidos en las pruebas
  private
  def match_pruebas(proyecto_id, ciclo)
    @metas_final = Lanzamiento::Meta.joins(:colaborador).where("colaboradors.proyecto_id = ? and lanzamiento_metas.ciclo = ?", proyecto_id, ciclo).to_json
    @disenos_final = Estrategia::Diseno.joins(:colaborador).where("colaboradors.proyecto_id = ? and estrategia_disenos.ciclo = ?", proyecto_id, ciclo).to_json
    @criterios_final = Estrategia::Criterio.joins(:colaborador).where("colaboradors.proyecto_id = ? and estrategia_criterios.ciclo = ?", proyecto_id, ciclo).to_json
    @estimaciones_final = Estrategia::Estimacion.joins(:colaborador).where("colaboradors.proyecto_id = ? and estrategia_estimaciones.ciclo = ?", proyecto_id, ciclo).to_json
    @planes_calidad_final = Planeacion::PlanCalidad.joins(:colaborador).where("colaboradors.proyecto_id = ? and planeacion_planes_calidad.ciclo = ?", proyecto_id, ciclo).to_json
    @requerimientos_final = Requerimientos::Requerimiento.joins(:colaborador).where("colaboradors.proyecto_id = ? and requerimientos_requerimientos.ciclo = ?", proyecto_id, ciclo).to_json
    @estructuras_final = Diseno::Estructura.joins(:colaborador).where("colaboradors.proyecto_id = ? and diseno_estructuras.ciclo = ?", proyecto_id, ciclo).to_json
    @planes_pruebas_final = Diseno::PlanPruebas.joins(:colaborador).where("colaboradors.proyecto_id = ? and diseno_plan_pruebas.ciclo = ?", proyecto_id, ciclo).to_json
    @estandares_final = Diseno::Estandar.joins(:colaborador).where("colaboradors.proyecto_id = ? and diseno_estandares.ciclo = ?", proyecto_id, ciclo).to_json
    @criterios_calidad_final = Implementacion::CriterioCalidad.joins(:colaborador).where("colaboradors.proyecto_id = ? and implementacion_criterios_calidad.ciclo = ?", proyecto_id, ciclo).to_json

    #Todas las pruebas aplicadas en el proyecto
    #@total_pruebas = Pruebas::Prueba.find_by_sql(["SELECT * FROM pruebas_pruebas AS D JOIN (SELECT id FROM colaboradors WHERE proyecto_id = ?) AS C ON D.colaborador_id = C.id AND ciclo = ?", proyecto_id, ciclo])
    @total_pruebas = Pruebas::Prueba.joins(:colaborador).where("colaboradors.proyecto_id = ? AND pruebas_pruebas.ciclo = ?", proyecto_id, ciclo)

    #Código para matchear las metas enlazadas en todas las pruebas
    @pruebas_metas = @total_pruebas.first.lanzamiento_metas
    @total_pruebas.each do |prueba|
      @pruebas_metas.match(prueba.lanzamiento_metas)
    end

    @pruebas_disenos = @total_pruebas.first.estrategia_disenos
    @total_pruebas.each do |prueba|
      @pruebas_disenos.match(prueba.estrategia_disenos)
    end
    
    @pruebas_criterios = @total_pruebas.first.estrategia_criterios
    @total_pruebas.each do |prueba|
      @pruebas_criterios.match(prueba.estrategia_criterios)
    end

    @pruebas_estimaciones = @total_pruebas.first.estrategia_estimaciones
    @total_pruebas.each do |prueba|
      @pruebas_estimaciones.match(prueba.estrategia_estimaciones)
    end

    @pruebas_planes_calidad = @total_pruebas.first.planeacion_planes_calidad
    @total_pruebas.each do |prueba|
      @pruebas_planes_calidad.match(prueba.planeacion_planes_calidad)
    end

    @pruebas_requerimientos = @total_pruebas.first.requerimientos_requerimientos
    @total_pruebas.each do |prueba|
      @pruebas_requerimientos.match(prueba.requerimientos_requerimientos)
    end

    @pruebas_estructuras = @total_pruebas.first.diseno_estructuras
    @total_pruebas.each do |prueba|
      @pruebas_estructuras.match(prueba.diseno_estructuras)
    end

    @pruebas_planes_pruebas = @total_pruebas.first.diseno_planes_pruebas
    @total_pruebas.each do |prueba|
      @pruebas_planes_pruebas.match(prueba.diseno_planes_pruebas)
    end

    @pruebas_estandares = @total_pruebas.first.diseno_estandares
    @total_pruebas.each do |prueba|
      @pruebas_estandares.match(prueba.diseno_estandares)
    end

    @pruebas_criterios_calidad = @total_pruebas.first.implementacion_criterios_calidad
    @total_pruebas.each do |prueba|
      @pruebas_criterios_calidad.match(prueba.implementacion_criterios_calidad)
    end

    #Codigo para encontrar las metas que no se hayan utilizado en el proyecto
    @resumen_metas = JSON.parse(@metas_final).difference(JSON.parse(@pruebas_metas))
    @resumen_disenos = JSON.parse(@disenos_final).difference(JSON.parse(@pruebas_disenos))
    @resumen_criterios = JSON.parse(@disenos_final).difference(JSON.parse(@pruebas_disenos))
    @resumen_estimaciones = JSON.parse(@estimaciones_final).difference(JSON.parse(@pruebas_estimaciones))
    @resumen_planes_calidad = JSON.parse(@planes_calidad_final).difference(JSON.parse(@pruebas_planes_calidad))
    @resumen_requerimientos = JSON.parse(@requerimientos_final).difference(JSON.parse(@pruebas_requerimientos))
    @resumen_estructuras = JSON.parse(@estructuras_final).difference(JSON.parse(@pruebas_estructuras))
    @resumen_planes_pruebas = JSON.parse(@planes_pruebas_final).difference(JSON.parse(@pruebas_planes_pruebas))
    @resumen_estandares = JSON.parse(@estandares_final).difference(JSON.parse(@pruebas_estandares))
    @resumen_criterios_calidad = JSON.parse(@criterios_calidad_final).difference(JSON.parse(@pruebas_criterios_calidad))
    #Arreglo con las diferencias de los metodos empleados
    @resumen_procesos = [@resumen_metas, @resumen_disenos, @resumen_criterios, @resumen_estimaciones, @resumen_planes_calidad, @resumen_requerimientos, @resumen_estructuras, @resumen_planes_pruebas, @resumen_estandares, @resumen_criterios_calidad]
    #Retorno de un arreglo con las procesos no empleados en el proyecto
    return @resumen_procesos
  end

  def parametros
    params.permit(:ciclo, :ciclo_actual, :proyecto_id)
  end

end
