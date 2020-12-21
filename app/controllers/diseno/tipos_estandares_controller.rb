class Diseno::TiposEstandaresController < ApplicationController
  
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
    @tipoEstandar = Diseno::TipoEstandar.new
  end

  def store
    #Definición e inicialización de nueva Diseno
    @tipoEstandar = Diseno::TipoEstandar.new(parametros)
    @tipoEstandar.proyecto_id = params[:proyecto_id]
    if(@tipoEstandar.save)
      #Impresión del proceso satisfactorio
      flash[:success] = "Tipo de Estándar Creado Correctamente"
    else
      #Impresión del proceso de error
      flash[:danger] = "No se pudo crear el Tipo de Estándar"
    end
    redirect_to diseno_tipos_estandares_index_path(:proyecto_id => params[:proyecto_id])
  end

  def edit
    @tipoEstandar = Diseno::TipoEstandar.find(params[:id])
    @tipoEstandar = Diseno::TipoEstandar.where(id: @tipoEstandar).first
    if @tipoEstandar.update(parametros)
      #Impresión del proceso satisfactorio
      flash[:success] = "Tipo de Estándar Actualizado Correctamente"
    else
      #Impresión del proceso de error
      flash[:danger] = "El Estándar No Se Actualizó"
    end
      redirect_to diseno_tipos_estandares_index_path(:proyecto_id => params[:proyecto_id])
  end

  def update
    begin
      @tipoEstandar = Diseno::TipoEstandar.find(params[:id])
      @tipoEstandar = Diseno::TipoEstandar.where(id: @tipoEstandar)
    rescue ActiveRecord::RecordNotFound => e
      @tipoEstandar = nil
      flash[:danger] = "No Se Encontró El Estándar"
      redirect_to diseno_tipos_estandares_index_path(:proyecto_id => params[:proyecto_id])
    end
  end

  def delete
    @tipoEstandar = Diseno::TipoEstandar.find(params[:id])
    Diseno::TipoEstandar.where(id: @tipoEstandar).destroy_all
    flash[:success] = "Estándar Eliminado"
    redirect_to diseno_tipos_estandares_index_path(:proyecto_id => params[:proyecto_id])
  end

  private
  def parametros
    params.permit( :nombre, :descripcion)
  end
end
