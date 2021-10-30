class ApplicationController < ActionController::API  
  before_action :authenticate!
  helper_method :current_user

  private

  def decoded
    @decoded ||= Authenticate::DecodeService.call headers: request.headers
  end

  def authenticate!
    render json: decoded.errors, status: :ok if decoded.fail?
  end

  def current_user
    if decoded.success?
      user_id = decoded.payload.first['user_id'] 
      @current_user ||= User.find_by(id: user_id)
    end
    @current_user ||= User.find_by access_api: params[:access_api] 
  rescue 
    nil
  end
end
