class DashboardController < ApplicationController
  
  before_action :authenticate_user!
  #load_and_authorize_resource class: "User"

  @root_url = "/dashboard/index"
  layout 'application_dashboard'

  add_flash_types :success, :danger, :info, :warning

  def index
    user = User.find_by_id(current_user.id)
    if user.valid_password?("AWIC0000")
      redirect_to dashboard_change_path
    end
  end

  def change
    user = User.find_by_id(current_user.id)
    if !user.valid_password?("AWIC0000")
      redirect_to dashboard_index_path
    end
  end

  def changePass
    if params[:password] != params[:confirmPass]
      flash[:warning] = "Las Contraseñas No Coinciden"
      redirect_to dashboard_change_path
    else
      @user = User.find(params[:id])
      @user.password = params[:password]
      @user.update(params.permit(:password))
      flash[:info] = "Se Ha Establecido La Nueva Contraseña"
      redirect_to dashboard_index_path
    end
  end

end
