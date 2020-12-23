class Diseno::EstandaresController < ApplicationController
  
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
    @diseno = Diseno::Estandar.new
    @tipos_estandares = nil
    if Diseno::TipoEstandar.where(proyecto_id: params[:proyecto_id]) == nil
      flash[:danger] = "No tiene registrado ningún tipo de estándar."
      redirect_to diseno_estandares_index_path(:proyecto_id => params[:proyecto_id])
    else
      @tipo_estandares = Diseno::TipoEstandar.where(proyecto_id: params[:proyecto_id])
    end
  end

  def store
    #Definición e inicialización de nueva Diseno
    @colaborador = Colaborador.where(proyecto_id: params[:proyecto_id], user_id: current_user.id).first
    @estandar = Diseno::Estandar.new(parametros)
    #obteniendo el ciclo del proyecto
    @estandar.diseno_tipo_estandar_id = params[:diseno_tipo_estandar_id];
    @estandar.ciclo = Proyecto.find(params[:proyecto_id]).ciclo_actual
    @estandar.colaborador_id = @colaborador.id
    if(@estandar.save)
      #Impresión del proceso satisfactorio
      flash[:success] = "Estándar creado Correctamente"
    else
      #Impresión del proceso satisfactorio
      flash[:danger] = "No se pudo crear el estándar"
    end
    redirect_to diseno_estandares_index_path(:proyecto_id => params[:proyecto_id])
  end

  def edit
    @estandar = Diseno::Estandar.find(params[:id])
    @estandar = Diseno::Estandar.where(id: @estandar).first
    if @estandar.update(parametros)
      #Impresión del proceso satisfactorio
      flash[:success] = "Estándar Actualizado Correctamente"
    else
      #Impresión del proceso satisfactorio
      flash[:danger] = "Estándar no se pudo actualizar"
    end
    redirect_to diseno_estandares_index_path(:proyecto_id => params[:proyecto_id])
  end

  def update
    begin
      @estandar = Diseno::Estandar.find(params[:id])
      @estandar = Diseno::Estandar.where(id: @estandar)
    rescue ActiveRecord::RecordNotFound => e
      @estandar = nil
      flash[:danger] = "No se encontró el estándar"
      redirect_to diseno_estandares_index_path(:proyecto_id => params[:proyecto_id])
    end
  end

  def delete
    @estandar = Diseno::Estandar.find(params[:id])
    Diseno::Estandares.where(id: @estandar).destroy_all
    flash[:success] = "Estándar de pruebas Eliminado"
    redirect_to diseno_estandares_index_path(:proyecto_id => params[:proyecto_id])
  end

  private
  def parametros
    params.permit(:nombre, :descripcion, :ciclo, :diseno_tipo_estandar_id)
  end
end
