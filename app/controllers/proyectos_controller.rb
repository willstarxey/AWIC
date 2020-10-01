class ProyectosController < ApplicationController

  before_action :authenticate_user!
  load_and_authorize_resource
  
  @root_url = "/proyectos/index"
  layout 'application_dashboard'

  add_flash_types :success, :danger, :info, :warning
  
  def index
  end

  def create
  end

  def search
  end

  def update
  end
end
