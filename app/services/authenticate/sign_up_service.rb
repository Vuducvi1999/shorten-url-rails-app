
# input: {name, email, password}
# output: a jwt token if valid
#         errors if invalid, errors: {name: ['cant be blank'], email: ['has already exist'], ...}

class Authenticate::SignUpService < BaseService
  def initialize params
    @user = User.create params
  end

  def call
    if @user.errors
      ResultService.new errors: @user.errors.messages
    else
      jwt = JWT.encode(payload, Rails.application.secrets.secret_key_base)
      ResultService.new payload: jwt
    end
  end

  private

  def payload
    {
      user_id: @user.id,
      exp: 3.hours.from_now.to_i
    }
  end
end
