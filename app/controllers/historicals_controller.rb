class HistoricalsController < ApplicationController
  def index
    @portion = Portion.find(params[:portion_id])
    @historicals = @portion.historicals
  end
end