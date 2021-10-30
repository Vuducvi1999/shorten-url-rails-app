module Accessable
  def check_access!
    invalid_access = current_user.nil?
    render json: invalid_access_api, status: :unauthorized if invalid_access
  end

  def invalid_access_api
    {
      errors: {
        messages: ['invalid access']
      }
    }
  end
end