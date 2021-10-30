class ManagementController < ApplicationController
  include Statusable
  skip_before_action :authenticate!, only: [:links]
  before_action :check_access_api!, only: [:links]

  def access_api 
    @user = current_user
    render :access_api, status: :ok
  end

  def links 
    @result_service = Management::ListLinksService.call(
      user: @user, 
      page: params[:page]
    )
    render :links, status: status
  end

  private

  def check_access_api!
    user = user_from_access_api
    render json: invalid_access_api if user.nil?
  end

  def user_from_access_api
    @user ||= User.includes(:shorten_urls).find_by access_api: params[:access_api]
  end

  def invalid_access_api
    {
      errors: {
        messages: ['invalid access api']
      }
    }
  end
end