class HomePageController < ApplicationController
  skip_before_action :authenticate!

  def home
    access_key = params[:access_key]
    render json: 'wellcome', status: :ok
  end
end