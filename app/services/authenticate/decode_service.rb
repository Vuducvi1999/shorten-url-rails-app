class Authenticate::DecodeService < BaseService
  def initialize(header = {})
    @header = header
    @errors = {}
    @payload = nil
  end

  def call
    return ResultService.new payload: @payload if token_valid?
    ResultService.new errors: @errors
  end

  private

  def token
    @header[:Authorization].split(' ').last if @header[:Authorization]
  end

  def token_valid?
    @payload = JWT.decode token, Rails.application.secrets.secret_key_base
  rescue JWT::ExpiredSignature
    @errors[:token] = 'Expired token'
    false
  rescue JWT::DecodeError
    @errors[:token] = 'Invalid token'
    false
  end
end
