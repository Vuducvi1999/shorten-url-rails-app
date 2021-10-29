class ApplicationController < ActionController::API  
  before_action :authenticate!

  private

  def authenticate!
    decoded = Authenticate::DecodeService.call request.headers
    render json: decoded.errors if decoded.fail?
  end
end
