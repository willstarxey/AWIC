class Diseno::EstructurasController < ApplicationController
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
    @diseno = Diseno::Estructura.new
  end

  def store
    #Definición e inicialización de nueva Diseno
    @colaborador = Colaborador.where(proyecto_id: params[:proyecto_id], user_id: current_user.id).first
    @estructura = Diseno::Estructura.new(parametros)
    #obteniendo el ciclo del proyecto
    @estructura.ciclo = Proyecto.find(params[:proyecto_id]).ciclo_actual
    @estructura.colaborador_id = @colaborador.id
    if(@estructura.save)
      #Impresión del proceso satisfactorio
      flash[:success] = "Estructura Creada Correctamente"
    else
      #Impresión del proceso satisfactorio
      flash[:danger] = "No se pudo crear la estructura"
    end
    redirect_to diseno_estructuras_index_path(:proyecto_id => params[:proyecto_id])
  end

  def edit
    @estructura = Diseno::Estructura.find(params[:id])
    @estructura = Diseno::Estructura.where(id: @estructura).first
    if @estructura.update(parametros)
      #Impresión del proceso satisfactorio
      flash[:success] = "Estructura Actualizado Correctamente"
    else
      #Impresión del proceso satisfactorio
      flash[:danger] = "La estructura no se pudo actualizar"
    end
    redirect_to diseno_estructuras_index_path(:proyecto_id => params[:proyecto_id])
  end

  def update
    begin
      @estructura = Diseno::Estructura.find(params[:id])
      @estructura = Diseno::Estructura.where(id: @estructura)
    rescue ActiveRecord::RecordNotFound => e
      @Diseno = nil
      flash[:danger] = "Estrucutra No Encontrada"
      redirect_to diseno_estructuras_index_path(:proyecto_id => params[:proyecto_id])
    end
  end

  def delete
    @estructura = Diseno::Estructura.find(params[:id])
    Diseno::Estructura.where(id: @estructura).destroy_all
    flash[:success] = "Estructura Eliminada"
    redirect_to diseno_estructuras_index_path(:proyecto_id => params[:proyecto_id])
  end

  private
  def parametros
    params.permit( :nombre, :descripcion, :ciclo)
  end
end
