class OpeningHour < ApplicationRecord
  belongs_to :establishment
  enum :day_of_week, {monday: 0, tuesday: 1, wednesday: 2, thursday: 3, friday: 4, saturday: 5, sunday: 6}
  before_validation :validate_uniqueness_of_day_of_week, on: :create
  validate :validate_opening_hours_before_closing

  
  def translated_day_of_week
    I18n.t("activerecord.attributes.opening_hour.day_of_week.#{day_of_week}.one")
  end

  def self.closed?(day, hour)
    horario_do_dia = OpeningHour.find_by(day_of_week: day) 
    horario_de_abertura = horario_do_dia.open_hour.strftime("%H:%M")
    horario_de_fechamento = horario_do_dia.close_hour.strftime("%H:%M")

    if hour >= horario_de_abertura  && hour <= horario_de_fechamento
      return false
    end

    true
  end

  private 

  def validate_uniqueness_of_day_of_week
    errors.add(:day_of_week, 'já está em uso') if Establishment.find(establishment_id).opening_hours.where(day_of_week: day_of_week).any?
  end 

  def validate_opening_hours_before_closing
    errors.add(:close_hour, 'não pode ser antes do horário de abertura') if close_hour && open_hour && close_hour < open_hour
  end
end
