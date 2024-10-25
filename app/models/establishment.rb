class Establishment < ApplicationRecord
  belongs_to :user
  validates :corporate_name, :brand_name, :restration_number,
  :full_address, :phone_number, :email, :code, :user_id, presence: true
  validate :valida_telefone, :valida_cnpj, :valida_email
  before_validation :generate_code, on: :create
  has_many :opening_hours
  has_many :dishes

  private 

  def valida_telefone
    errors.add(:phone_number, 'é muito curto') unless phone_number.length == 10 || phone_number.length == 11
  end

  def valida_cnpj
    errors.add(:restration_number, 'inválido') unless CNPJ.valid?(restration_number, strict: true)
  end

  def valida_email
    regra = /\A[^@\s]+@[^@\s]+\.[a-z]{2,}\z/
    errors.add(:restration_number, 'inválido') unless regra.match(email)
  end

  def generate_code
    self.code = SecureRandom.alphanumeric(6).upcase
  end
end
