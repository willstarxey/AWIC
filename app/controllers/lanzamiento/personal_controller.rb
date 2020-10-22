class Lanzamiento::PersonalController < ApplicationController

  before_action :authenticate_user!
  #load_and_authorize_resource

  layout 'application_dashboard'

  def index
    if params[:proyecto_id]
      begin
        @colaboradors = Colaborador.where(proyecto_id: params[:proyecto_id], lider: false)
      rescue ActiveRecord::RecordNotFound => e
        flash[:danger] = "No se encuentran registros"
        redirect_to dashboard_index_path
      end
    else
      flash[:info] = "No se seleccionó ningún proyecto"
      redirect_to dashboard_index_path
    end
  end

  def add
    @users = User.find_by_sql("SELECT * FROM users AS U WHERE role_id != 1 AND U.id NOT IN (SELECT C.user_id FROM colaboradors as C WHERE C.proyecto_id = #{ params[:proyecto_id] })")
  end

  def store
    @colaborador = Colaborador.new(parametros)
    @colaborador.lider = false
    @colaborador.added_at = Time.now
    if @colaborador.save
      flash[:success] = "Se ha agregado al usuario satisfactoriamente"
      redirect_to lanzamiento_personal_index_path(:proyecto_id => params[:proyecto_id])
    else
      flash[:danger] = "No se pudo agregar el usuario al proyecto"
      redirect_to lanzamiento_personal_index_path(:proyecto_id => params[:proyecto_id])
    end
  end

  def delete
    @colaborador = Colaborador.find(params[:id])
    Colaborador.where(id: @colaborador).destroy_all
    flash[:success] = "Usuario eliminado del proyecto correctamente"
    redirect_to lanzamiento_personal_index_path(:proyecto_id => params[:proyecto_id])
  end

  private 
  def parametros
    params.permit(:proyecto_id, :user_id)
  end

end
