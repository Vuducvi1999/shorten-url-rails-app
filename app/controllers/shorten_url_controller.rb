class ShortenUrlController < ApplicationController
  include Statusable
  include Accessable
  
  skip_before_action :authenticate!
  before_action :check_access!, only: %i[compress]

  def compress
    @result_service = ShortenUrl::CompressService.call(
      origin: params[:origin_url], 
      user: current_user
    )
    render :compress, status: status
  end

  def direct
    @result_service = ShortenUrl::DirectService.call shorten_url: request.url 
    redirect_to @result_service.payload.origin if @result_service.success?
  end  
end