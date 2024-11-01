class MarkersController < ApplicationController
  def new
    @marker = Marker.new
    @establishment = Establishment.find(params[:establishment_id])
  end

  def create
    marker_params = params.require(:marker).permit(:description)
    @marker = Marker.create!(marker_params)

    redirect_to establishment_dishes_path(establishment_id: params[:establishment_id])
  end
end