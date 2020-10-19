class Lanzamiento::MetasController < ApplicationController

  before_action :authenticate_user!
  load_and_authorize_resource

  layout 'application_dashboard'

  def index
    begin
      @proyecto = Proyecto.find(params[:proyecto_id])
      @colaboradors = Colaborador.where(proyecto_id: params[:proyecto_id])
    rescue ActiveRecord::RecordNotFound => e
      flash[:danger] = "No se ha seleccionado el proyecto"
      redirect_to dashboard_index_path
    end
  end

  def create
  end

  def update
    @meta = Lanzamiento::Meta.find(params[:id])
    @meta = Lanzamiento::Meta.where(id: @meta)
  end

  def delete
  end
end
