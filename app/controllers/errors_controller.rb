class ErrorsController < ApplicationController

  layout 'application'

  skip_before_action :authenticate_user!

  def not_found
    status_code = params[:code] || 404
  end

  def unacceptable
    status_code = params[:code] || 422
  end

  def internal_error
    status_code = params[:code] || 500
  end
end
