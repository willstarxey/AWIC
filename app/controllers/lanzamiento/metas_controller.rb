class Lanzamiento::MetasController < ApplicationController

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
    @meta = Lanzamiento::Meta.new
  end

  def store
    #Definición e inicialización de nueva meta
    @colaborador = Colaborador.where(proyecto_id: params[:proyecto_id], user_id: current_user.id).first
    @meta = Lanzamiento::Meta.new(parametros)
    @meta.colaborador_id = @colaborador.id
    if(@meta.save)
      #Impresión del proceso satisfactorio
      flash[:success] = "Meta Creada Correctamente"
      redirect_to lanzamiento_metas_index_path(:proyecto_id => params[:proyecto_id])
    else
      #Impresión del proceso de error
      flash[:danger] = "No se pudo crear la meta"
      redirect_to lanzamiento_metas_index_path(:proyecto_id => params[:proyecto_id])
    end
  end

  def edit
    @meta = Lanzamiento::Meta.find(params[:id])
    @meta = Lanzamiento::Meta.where(id: @meta).first
    if @meta.update(parametros)
      #Impresión del proceso satisfactorio
      flash[:success] = "Meta Actualizada Correctamente"
      redirect_to lanzamiento_metas_index_path(:proyecto_id => params[:proyecto_id])
    else
      #Impresión del proceso de error
      flash[:danger] = "No se pudo actualizar la meta"
      redirect_to lanzamiento_metas_index_path(:proyecto_id => params[:proyecto_id])
    end
  end

  def update
    begin
      @meta = Lanzamiento::Meta.find(params[:id])
      @meta = Lanzamiento::Meta.where(id: @meta)
    rescue ActiveRecord::RecordNotFound => e
      @meta = nil
      flash[:danger] = "Meta No Registrado"
      redirect_to lanzamiento_metas_index_path(:proyecto_id => params[:proyecto_id])
    end
  end

  def delete
    @meta = Lanzamiento::Meta.find(params[:id])
    Lanzamiento::Meta.where(id: @meta).destroy_all
    flash[:success] = "Meta Eliminada"
    redirect_to lanzamiento_metas_index_path(:proyecto_id => params[:proyecto_id])
  end

  private
  def parametros
    params.permit(:descripcion, :plazo)
  end
end
