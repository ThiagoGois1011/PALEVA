class OpeningHour < ApplicationRecord
  belongs_to :establishment
  enum :day_of_week, {monday: 0, tuesday: 1, wednesday: 2, thursday: 3, friday: 4, saturday: 5, sunday: 6}

  def self.closed?(day, hour)
    horario_do_dia = OpeningHour.find_by(day_of_week: day) 
    horario_de_abertura = horario_do_dia.open_hour.strftime("%H:%M")
    horario_de_fechamento = horario_do_dia.close_hour.strftime("%H:%M")

    if hour >= horario_de_abertura  && hour <= horario_de_fechamento
      return false
    end

    true
  end
end
