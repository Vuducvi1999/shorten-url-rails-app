
# input: {email, password}
# output: a jwt token if valid
#         errors if invalid, errors: {email: ['wrong email']} || {password: ['wrong password']}

class Authenticate::SignInService < BaseService
  def initialize params
    @email = params[:email]
    @password = params[:password]
  end

  def call
    return ResultService.new errors: errors if user.nil?
    
    jwt = JWT.encode(payload, Rails.application.secrets.secret_key_base)
    ResultService.new payload: jwt
  end

  private

  def user
    user = User.find_by email: @email
    return user if user && user.authenticate(@password)
  end

  def errors
    result = {}
    user = User.find_by email: @email
    result[:email] = ['wrong email'] unless user
    result[:password] = ['wrong password'] if user.try(:authenticate, @password) == false
    result
  end

  def payload
    {
      user_id: user.id,
      exp: 3.hours.from_now.to_i
    }
  end
end
