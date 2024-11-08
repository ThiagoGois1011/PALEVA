class Order < ApplicationRecord
  belongs_to :establishment
  belongs_to :user
  validates :name, presence: true
  validate :validate_cpf, :validate_phone_number_and_email, :validate_phone_number, :validate_email

  private 

  def validate_cpf
    errors.add(:cpf, 'inválido') if !cpf.blank? && !CPF.valid?(cpf, strict: true)
  end

  def validate_phone_number_and_email
    if email.blank? && phone_number.blank? 
      errors.add(:base, 'Pedido deve ter um telefone ou email')
    end
  end

  def validate_phone_number
    if !phone_number.blank?
      errors.add(:phone_number, 'é muito curto') if phone_number.length < 10 
      errors.add(:phone_number, 'é muito longo') if phone_number.length > 11
      errors.add(:phone_number, 'deve ter somente números') unless phone_number.match?(/\A\d+\z/)
    end
  end

  def validate_email
    if !email.blank?
      regra = /\A[^@\s]+@[^@\s]+\.[a-z]{2,}\z/
      errors.add(:email, 'inválido') unless regra.match(email)
    end
  end
end
