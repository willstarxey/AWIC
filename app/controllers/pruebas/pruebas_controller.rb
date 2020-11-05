class Pruebas::PruebasController < ApplicationController
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
    @prueba = Pruebas::Prueba.new
  end

  def store
    #Definición e inicialización de nueva Prueba
    @colaborador = Colaborador.where(proyecto_id: params[:proyecto_id], user_id: current_user.id).first
    @prueba = Pruebas::Prueba.new(parametros)
    @prueba.colaborador_id = @colaborador.id
    if(@prueba.save)
      #Impresión del proceso satisfactorio
      flash[:success] = "Prueba Creada Correctamente"
      redirect_to pruebas_pruebas_index_path(:proyecto_id => params[:proyecto_id])
    else
      #Impresión del proceso de error
      flash[:danger] = "No se pudo crear la Prueba"
      redirect_to pruebas_pruebas_index_path(:proyecto_id => params[:proyecto_id])
    end
  end

  def edit
    @prueba = Pruebas::Prueba.find(params[:id])
    @prueba = Pruebas::Prueba.where(id: @prueba).first
    if @prueba.update(parametros)
      #Impresión del proceso satisfactorio
      flash[:success] = "Prueba Actualizada Correctamente"
      redirect_to pruebas_pruebas_index_path(:proyecto_id => params[:proyecto_id])
    else
      #Impresión del proceso de error
      flash[:danger] = "No se pudo actualizar la Prueba"
      redirect_to pruebas_pruebas_index_path(:proyecto_id => params[:proyecto_id])
    end
  end

  def update
    begin
      @prueba = Pruebas::Prueba.find(params[:id])
      @prueba = Pruebas::Prueba.where(id: @prueba)
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
    params.permit(:nombre, :descripcion, :entrada, :r_obtenido, :r_deseado, :cunmple, :ciclo, :lanzamiento, :estrategia, :planeacion,
      :requerimientos, :diseno, :implementacion ,:plazo)
  end
end
