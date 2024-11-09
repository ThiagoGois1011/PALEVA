class MarkersController < ApplicationController
  def new
    @marker = Marker.new
    @establishment = current_establishment
  end

  def create
    marker_params = params.require(:marker).permit(:description)
    @marker = Marker.create!(marker_params)

    redirect_to establishment_dishes_path
  end
end