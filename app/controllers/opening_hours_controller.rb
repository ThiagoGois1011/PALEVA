class OpeningHoursController < ApplicationController
  before_action :check_if_exist_opening_days, only: [:new, :create]
  skip_before_action :check_if_establishment_or_opening_hour_is_nil, only: [:new, :create]
  
  def new
    @opening_hour = OpeningHour.new
  end

  def create
    establishment = Establishment.find(params[:establishment_id])

    if params[:check_separate_days] == '0'
      days_of_week = {business_day: params.require(:opening_hour).require(:business_day).permit(:open_hour, :close_hour, :closed)}
      days_of_week[:saturday] = params.require(:opening_hour).require(:saturday).permit(:open_hour, :close_hour, :closed)
      days_of_week[:sunday] = params.require(:opening_hour).require(:sunday).permit(:open_hour, :close_hour, :closed)
      
      days_of_week.each do |chave, valor|
        if chave == :business_day
          5.times do |day|
            if valor[:closed] == '0'
              OpeningHour.create!(establishment: establishment, open_hour: valor[:open_hour], close_hour: valor[:close_hour], day_of_week: day)
            elsif valor[:closed] == '1'
              OpeningHour.create!(establishment: establishment, day_of_week: day)
            end
          end
        else
          if valor[:closed] == '0'
            OpeningHour.create!(establishment: establishment, open_hour: valor[:open_hour], close_hour: valor[:close_hour], day_of_week: chave.to_sym)
          elsif valor[:closed] == '1'
            OpeningHour.create!(establishment: establishment, day_of_week: chave.to_sym)
          end
        end
      end
    elsif params[:check_separate_days] == '1'
      days_of_week = params.require(:opening_hour).require(:separate_days)
      days_of_week[:saturday] = params.require(:opening_hour).require(:saturday).permit(:open_hour, :close_hour, :closed)
      days_of_week[:sunday] = params.require(:opening_hour).require(:sunday).permit(:open_hour, :close_hour, :closed)
      
      days_of_week.each do |chave, valor|
        
        if valor[:closed] == '0'
          OpeningHour.create!(establishment: establishment, open_hour: valor[:open_hour], close_hour: valor[:close_hour], day_of_week: chave.to_sym)
        elsif valor[:closed] == '1'
          OpeningHour.create!(establishment: establishment, day_of_week: chave.to_sym)
        end
      end
    end
    
    redirect_to establishment, notice: 'Horário de abertura cadastrado com sucesso.'
  end

  private 

  def check_if_exist_opening_days
    redirect_to current_user.establishment, notice: 'Todos os dias já foram cadastrados.' if current_user.establishment.opening_hours.length > 6
  end
end