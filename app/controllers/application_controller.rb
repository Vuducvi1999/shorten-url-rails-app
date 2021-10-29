class ApplicationController < ActionController::API  
  before_action :authenticate!, :test
  helper_method :current_user

  private

  def test 
    # a= ShortenUrl::DirectService.call shorten_url: 'http://localhost:3000/'
    # byebug
  end

  def decoded
    @decoded ||= Authenticate::DecodeService.call request.headers
  end

  def authenticate!
    render json: decoded.errors, status: :unauthorized if decoded.fail?
  end

  def current_user
    user_id = decoded.payload.first['user_id']
    User.find_by id: user_id
  end
end
