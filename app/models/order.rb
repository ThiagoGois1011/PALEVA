class Order < ApplicationRecord
  belongs_to :establishment
  belongs_to :user, optional: true
  validates :name, presence: true
  validate :validate_cpf, :validate_phone_number_and_email, :validate_phone_number, :validate_email
  enum :status, {creating_order: 0, waiting_for_confirmation: 2, in_preparation: 4, cancelled: 6, ready: 8, delivered: 10}
  has_many :order_items
  has_many :portions, through: :order_items

  def self.generate_code
    SecureRandom.alphanumeric(8).upcase
  end

  def total_to_pay
    self.portions.reduce(0) { |total, product| total + product.price }
  end
  
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

  def generate_code
    self.code = SecureRandom.alphanumeric(6).upcase
  end
end
