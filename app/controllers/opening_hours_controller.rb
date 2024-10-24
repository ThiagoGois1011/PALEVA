class OpeningHoursController < ApplicationController
  def new
    @opening_hour = OpeningHour.new
  end

  def create
    establishment = Establishment.find(params[:establishment_id])
    5.times do |day| 
      
      OpeningHour.create!(establishment: establishment, open_hour: params[:opening_business_hour], 
                          close_hour: params[:closing_business_hour], day_of_week: day)               
    end

    if params[:closed_on_saturday]
      OpeningHour.create!(establishment: establishment, day_of_week: :saturday)
    else
      OpeningHour.create!(establishment: establishment, open_hour: params[:saturday_opening_time], 
                          close_hour: params[:saturday_closing_time], day_of_week: :saturday)
    end

    if params[:closed_on_sunday]
      OpeningHour.create!(establishment: establishment, day_of_week: :sunday)
    else
      OpeningHour.create!(establishment: establishment, open_hour: params[:sunday_opening_time], 
                          close_hour: params[:sunday_closing_time], day_of_week: :sunday)
    end
    

    redirect_to establishment, notice: 'Horário de abertura cadastrado com sucesso.'
  end
end