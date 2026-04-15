class ApisController < ApplicationController


  def index
    @apis = Api.all
  end

  def new
    @api = Api.new
  end

  def create
    @api = Api.new(api_params)
    if @api.save
      redirect_to apis_path
    else
      render :new
    end
  end

  private

  def api_params
    params.require(:api).permit(:name, :url)
  end
  
end