class Estrategia::CriteriosController < ApplicationController
  
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
    @criterio = Estrategia::Criterio.new
  end

  def store
    #Definición e inicialización de nueva Criterio
    @colaborador = Colaborador.where(proyecto_id: params[:proyecto_id], user_id: current_user.id).first
    @criterio = Estrategia::Criterio.new(parametros)
    @criterio.colaborador_id = @colaborador.id
    if(@criterio.save)
      #Impresión del proceso satisfactorio
      flash[:success] = "Criterio Creado Correctamente"
      redirect_to estrategia_criterios_index_path(:proyecto_id => params[:proyecto_id])
    else
      #Impresión del proceso de error
      flash[:danger] = "No se pudo crear el Criterio"
      redirect_to estrategia_criterios_index_path(:proyecto_id => params[:proyecto_id])
    end
  end

  def edit
    @criterio = Estrategia::Criterio.find(params[:id])
    @criterio = Estrategia::Criterio.where(id: @criterio).first
    if @criterio.update(parametros)
      #Impresión del proceso satisfactorio
      flash[:success] = "Criterio Actualizado Correctamente"
      redirect_to estrategia_criterios_index_path(:proyecto_id => params[:proyecto_id])
    else
      #Impresión del proceso de error
      flash[:danger] = "No se pudo actualizar el Criterio"
      redirect_to estrategia_criterios_index_path(:proyecto_id => params[:proyecto_id])
    end
  end

  def update
    begin
      @criterio = Estrategia::Criterio.find(params[:id])
      @criterio = Estrategia::Criterio.where(id: @criterio)
    rescue ActiveRecord::RecordNotFound => e
      @criterio = nil
      flash[:danger] = "Criterio No Registrado"
      redirect_to estrategia_criterios_index_path(:proyecto_id => params[:proyecto_id])
    end
  end

  def delete
    @criterio = Estrategia::Criterio.find(params[:id])
    Estrategia::Criterio.where(id: @criterio).destroy_all
    flash[:success] = "Criterio Eliminado"
    redirect_to estrategia_criterios_index_path(:proyecto_id => params[:proyecto_id])
  end

  private
  def parametros
    params.permit(:descripcion, :ciclo)
  end
end
