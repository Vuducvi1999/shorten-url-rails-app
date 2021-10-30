class ManagementController < ApplicationController
  include Statusable
  include Accessable

  skip_before_action :authenticate!, except: %i[access_api]
  before_action :check_access!, except: %i[access_api]

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

  def detail
    @result_service = Management::DetailService.call alias_path: params[:alias]
    render :detail, status: status
  end

  def edit 
    @result_service = Management::EditService.call(
      alias_path: params[:alias],
      origin_changed: params[:origin_changed]
    )
    render :edit, status: status
  end

  def destroy 
    @result_service = Management::DestroyService.call alias_path: params[:alias]
    render :destroy, status: status
  end
end