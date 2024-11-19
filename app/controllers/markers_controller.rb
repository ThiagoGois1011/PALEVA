class MarkersController < ApplicationController
  def new
    @marker = Marker.new
  end

  def create
    marker_params = params.require(:marker).permit(:description)
    @marker = Marker.new(**marker_params, establishment: current_establishment)

    save_model(model: @marker, notice_sucess: 'Marcador cadastrado com sucesso.', 
               notice_failure: 'Marcador não cadastrado.', redirect_url: establishment_dishes_path)
  end
end