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
    @total_pruebas = Pruebas::Prueba.joins(:colaborador).where("colaboradors.proyecto_id = ? AND pruebas_pruebas.ciclo = ?", proyecto_id, ciclo)

    #Código para matchear las metas enlazadas en todas las pruebas
    @pruebas_metas = []
    @total_pruebas.each do |prueba|
      if !prueba.lanzamiento_metas.nil?
        JSON.parse(prueba.lanzamiento_metas).each do |meta|
          if !@pruebas_metas.include? meta
            @pruebas_metas.push(meta)
          end
        end
      end
    end

    @pruebas_disenos = []
    @total_pruebas.each do |prueba|
      if !prueba.estrategia_disenos.nil?
        JSON.parse(prueba.estrategia_disenos).each do |diseno|
          if !@pruebas_disenos.include? diseno
            @pruebas_disenos.push(diseno)
          end
        end
      end
    end

    @pruebas_criterios = []
    @total_pruebas.each do |prueba|
      if !prueba.estrategia_criterios.nil?
        JSON.parse(prueba.estrategia_criterios).each do |criterio|
          if !@pruebas_criterios.include? criterio
            @pruebas_criterios.push(criterio)
          end
        end
      end
    end

    @pruebas_estimaciones = []
    @total_pruebas.each do |prueba|
      if !prueba.estrategia_estimaciones.nil?
        JSON.parse(prueba.estrategia_estimaciones).each do |estimacion|
          if !@pruebas_estimaciones.include? estimacion
            @pruebas_estimaciones.push(estimacion)
          end
        end
      end
    end

    @pruebas_planes_calidad = []
    @total_pruebas.each do |prueba|
      if !prueba.planeacion_planes_calidad.nil?
        JSON.parse(prueba.planeacion_planes_calidad).each do |plan_calidad|
          if !@pruebas_planes_calidad.include? plan_calidad
            @pruebas_planes_calidad.push(plan_calidad)
          end
        end
      end
    end

    @pruebas_requerimientos = []
    @total_pruebas.each do |prueba|
      if !prueba.requerimientos_requerimientos.nil?
        JSON.parse(prueba.requerimientos_requerimientos).each do |requerimiento|
          if !@pruebas_requerimientos.include? requerimiento
            @pruebas_requerimientos.push(requerimiento)
          end
        end
      end
    end

    @pruebas_estructuras = []
    @total_pruebas.each do |prueba|
      if !prueba.diseno_estructuras.nil?
        JSON.parse(prueba.diseno_estructuras).each do |estructura|
          if !@pruebas_estructuras.include? estructura
            @pruebas_estructuras.push(estructura)
          end
        end
      end
    end


    @pruebas_planes_pruebas = []
    @total_pruebas.each do |prueba|
      if !prueba.diseno_planes_pruebas.nil?
        JSON.parse(prueba.diseno_planes_pruebas).each do |plan_pruebas|
          if !@pruebas_planes_pruebas.include? plan_pruebas
            @pruebas_planes_pruebas.push(plan_pruebas)
          end
        end
      end
    end

    @pruebas_estandares = []
    @total_pruebas.each do |prueba|
      if !prueba.diseno_estandares.nil?
        JSON.parse(prueba.diseno_estandares).each do |estandar|
          if !@pruebas_estandares.include? estandar
            @pruebas_estandares.push(estandar)
          end
        end
      end
    end

    @pruebas_criterios_calidad = []
    @total_pruebas.each do |prueba|
      if !prueba.implementacion_criterios_calidad.nil?
        JSON.parse(prueba.implementacion_criterios_calidad).each do |criterio|
          if !@pruebas_criterios_calidad.include? criterio
            @pruebas_criterios_calidad.push(criterio)
          end
        end
      end
    end

    #Codigo para encontrar las metas que no se hayan utilizado en el proyecto
    @resumen_metas = JSON.parse(@metas_final).difference(@pruebas_metas)
    @resumen_disenos = JSON.parse(@disenos_final).difference(@pruebas_disenos)
    @resumen_criterios = JSON.parse(@disenos_final).difference(@pruebas_disenos)
    @resumen_estimaciones = JSON.parse(@estimaciones_final).difference(@pruebas_estimaciones)
    @resumen_planes_calidad = JSON.parse(@planes_calidad_final).difference(@pruebas_planes_calidad)
    @resumen_requerimientos = JSON.parse(@requerimientos_final).difference(@pruebas_requerimientos)
    @resumen_estructuras = JSON.parse(@estructuras_final).difference(@pruebas_estructuras)
    @resumen_planes_pruebas = JSON.parse(@planes_pruebas_final).difference(@pruebas_planes_pruebas)
    @resumen_estandares = JSON.parse(@estandares_final).difference(@pruebas_estandares)
    @resumen_criterios_calidad = JSON.parse(@criterios_calidad_final).difference(@pruebas_criterios_calidad)
    #Arreglo con las diferencias de los metodos empleados
    @resumen_procesos = [@resumen_metas, @resumen_disenos, @resumen_criterios, @resumen_estimaciones, @resumen_planes_calidad, @resumen_requerimientos, @resumen_estructuras, @resumen_planes_pruebas, @resumen_estandares, @resumen_criterios_calidad]
    #Retorno de un arreglo con las procesos no empleados en el proyecto
    return @resumen_procesos
  end

  def parametros
    params.permit(:ciclo, :ciclo_actual, :proyecto_id, :detalles)
  end

end
