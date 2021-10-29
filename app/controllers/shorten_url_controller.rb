class ShortenUrlController < ApplicationController
  include Statusable
  skip_before_action :authenticate!, only: [:direct]

  def compress
    @result_service = ShortenUrl::CompressService.call(
      origin: params[:origin_url], 
      user: current_user
    )
    render :compress, status: status
  end

  def direct
    @result_service = ShortenUrl::DirectService.call shorten_url: request.url 
    redirect_to 'http://google.com' if @result_service.success?
    # render :direct, status: status
  end    
end