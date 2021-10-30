
# input: request.headers
# output: token string if sign in success
#         errors if sign in fail

class Authenticate::DecodeService < BaseService
  def initialize headers:{}
    @headers = headers
    @errors = {}
    @payload = nil
  end

  def call
    return ResultService.new errors: @errors unless token_valid?
    ResultService.new payload: @payload, status: :accepted
  end

  private

  def token
    @headers[:Authorization].split(' ').last if @headers[:Authorization]
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
