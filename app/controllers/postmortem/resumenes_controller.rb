class Postmortem::ResumenesController < ApplicationController
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
    @Resumen = Postmortem::Resumen.new
  end

  def store
    #Definición e inicialización de nueva Postmortem
    @colaborador = Colaborador.where(proyecto_id: params[:proyecto_id], user_id: current_user.id).first
    @resumen = Postmortem::Resumen.new(parametros)
    @resumen.colaborador_id = @colaborador.id
    if(@resumen.save)
      #Impresión del proceso satisfactorio
      flash[:success] = "Resumen Creado Correctamente"
      redirect_to postmortem_resumenes_index_path(:proyecto_id => params[:proyecto_id])
    else
      #Impresión del proceso de error
      flash[:danger] = "No se pudo crear el Resumen"
      redirect_to postmortem_resumenes_index_path(:proyecto_id => params[:proyecto_id])
    end
  end

  def edit
    @resumen = Postmortem::Resumen.find(params[:id])
    @resumen = Postmortem::Resumen.where(id: @resumen).first
    if @resumen.update(parametros)
      #Impresión del proceso satisfactorio
      flash[:success] = "Resumen Actualizado Correctamente"
      redirect_to postmortem_resumenes_index_path(:proyecto_id => params[:proyecto_id])
    else
      #Impresión del proceso de error
      flash[:danger] = "Resumen actualiza la estimación"
      redirect_to postmortem_resumenes_index_path(:proyecto_id => params[:proyecto_id])
    end
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

  def delete
    @resumen = Postmortem::Resumen.find(params[:id])
    Postmortem::Resumen.where(id: @resumen).destroy_all
    flash[:success] = "Resumen Eliminado"
    redirect_to postmortem_resumen_index_path(:proyecto_id => params[:proyecto_id])
  end

  private
  def parametros
    params.permit(:ciclo, :lanzamiento, :estrategia, :planeacion, :requerimientos, :diseno, :implementacion ,:plazo)
  end
end
