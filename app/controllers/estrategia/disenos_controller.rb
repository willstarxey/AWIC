class Estrategia::DisenosController < ApplicationController

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
    @diseno = Estrategia::Diseno.new
  end

  def store
    #Definición e inicialización de nueva Diseno
    @colaborador = Colaborador.where(proyecto_id: params[:proyecto_id], user_id: current_user.id).first
    @diseno = Estrategia::Diseno.new(parametros)
    @diseno.colaborador_id = @colaborador.id
    if(@diseno.save)
      #Impresión del proceso satisfactorio
      flash[:success] = "Diseño Creado Correctamente"
      redirect_to estrategia_disenos_index_path(:proyecto_id => params[:proyecto_id])
    else
      #Impresión del proceso de error
      flash[:danger] = "No se pudo crear el Diseño"
      redirect_to estrategia_disenos_index_path(:proyecto_id => params[:proyecto_id])
    end
  end

  def edit
    @diseno = Estrategia::Diseno.find(params[:id])
    @diseno = Estrategia::Diseno.where(id: @diseno).first
    if @diseno.update(parametros)
      #Impresión del proceso satisfactorio
      flash[:success] = "Diseño Actualizado Correctamente"
      redirect_to estrategia_disenos_index_path(:proyecto_id => params[:proyecto_id])
    else
      #Impresión del proceso de error
      flash[:danger] = "No se pudo actualizar el Diseño"
      redirect_to estrategia_disenos_index_path(:proyecto_id => params[:proyecto_id])
    end
  end

  def update
    begin
      @diseno = Estrategia::Diseno.find(params[:id])
      @diseno = Estrategia::Diseno.where(id: @diseno)
    rescue ActiveRecord::RecordNotFound => e
      @diseno = nil
      flash[:danger] = "Diseño No Registrado"
      redirect_to estrategia_disenos_index_path(:proyecto_id => params[:proyecto_id])
    end
  end

  def delete
    @diseno = Estrategia::Diseno.find(params[:id])
    Estrategia::Diseno.where(id: @diseno).destroy_all
    flash[:success] = "Diseño Eliminado"
    redirect_to estrategia_disenos_index_path(:proyecto_id => params[:proyecto_id])
  end

  private
  def parametros
    params.permit(:descripcion_producto, :tamaño, :ciclo)
  end
end
