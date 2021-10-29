class AuthenticateController < ApplicationController
  skip_before_action :authenticate!

  def sign_in
    @service_sign_in = service_sign_in
    render :sign_in, status: status
  end

  def sign_up
    @service_sign_up = service_sign_up
    render :sign_up, status: status
  end

  private

  def params_sign_up
    params.permit(:name, :email, :password)
  end

  def params_sign_in
    params.permit(:email, :password)
  end

  def service_sign_in
    @sign_in ||= Authenticate::SignInService.call params_sign_in
  end

  def service_sign_up
    @sign_up ||= Authenticate::SignUpService.call params_sign_up
  end

  def status
    service_sign_in.success? ? :ok : :bad_request
  end
end
