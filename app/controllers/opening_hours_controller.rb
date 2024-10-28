class OpeningHoursController < ApplicationController
  before_action :check_if_exist_opening_days, only: [:new, :create]
  skip_before_action :check_if_establishment_or_opening_hour_is_nil, only: [:new, :create]
  
  def new
    @opening_hour = OpeningHour.new
  end

  def create
    establishment = Establishment.find(params[:establishment_id])
    5.times do |day| 
      
      OpeningHour.create!(establishment: establishment, open_hour: params[:opening_business_hour], 
                          close_hour: params[:closing_business_hour], day_of_week: day)               
    end

    if params[:closed_on_saturday] != '0'
      OpeningHour.create!(establishment: establishment, day_of_week: :saturday)
    else params[:closed_on_saturday] 
      OpeningHour.create!(establishment: establishment, open_hour: params[:saturday_opening_time], 
                          close_hour: params[:saturday_closing_time], day_of_week: :saturday)
    end

    if params[:closed_on_sunday] != '0'
      OpeningHour.create!(establishment: establishment, day_of_week: :sunday)
    else params[:closed_on_sunday]
      OpeningHour.create!(establishment: establishment, open_hour: params[:sunday_opening_time], 
                          close_hour: params[:sunday_closing_time], day_of_week: :sunday)
    end
    

    redirect_to establishment, notice: 'Horário de abertura cadastrado com sucesso.'
  end

  private 

  def check_if_exist_opening_days
    redirect_to current_user.establishment, notice: 'Todos os dias já foram cadastrados.' if current_user.establishment.opening_hours.length > 6
  end
end