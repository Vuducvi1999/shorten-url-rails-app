class HomePageController < ApplicationController 
  skip_before_action :authenticate! 

  def home 
    access_api = params[:access_api] 
    render json: 'wellcome', status: :ok 
  end 
end 