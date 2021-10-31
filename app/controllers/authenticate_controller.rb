class AuthenticateController < ApplicationController
  include Statusable
  skip_before_action :authenticate!

  def sign_in
    @result_service = Authenticate::SignInService.call params_sign_in
    render :sign_in, status: status
  end

  def sign_up
    @result_service = Authenticate::SignUpService.call params_sign_up
    render :sign_up, status: status
  end

  private

  def params_sign_up
    params.permit(:name, :email, :password)
  end

  def params_sign_in
    params.permit(:email, :password)
  end
end
