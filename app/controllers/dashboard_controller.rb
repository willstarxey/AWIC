class DashboardController < ApplicationController
  
  @root_url = "/dashboard/index"

  layout 'application_dashboard'

  def index
    user = User.find_by_id(current_user.id)
    if user.valid_password?("AWIC0000")
      redirect_to dashboard_change_path
    end
  end

  def change
  end

  def changePass
    if params[:password] != params[:confirmPass]
      @ini = "/dashboard/change"
      flash[:notice] = "Las Contraseñas No Coinciden"
      redirect_to @ini
    else
      @user = User.find(params[:id])
      @user.password = params[:password]
      @user.update(params.permit(:password))
      @ini = "/dashboard/index"
      flash[:notice] = "Se Ha Establecido La Nueva Contraseña"
      redirect_to @ini
    end
  end

end
