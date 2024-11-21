class Establishment < ApplicationRecord
  belongs_to :user, class_name: 'Owner', foreign_key: 'user_id'
  validates :corporate_name, :brand_name, :restration_number,
  :full_address, :phone_number, :email, :code, :user_id, presence: true
  validates :email, :phone_number, :restration_number, :code,  uniqueness: true
  validate :validate_phone_number, :validate_cnpj, :validate_email
  before_validation :generate_code, on: :create
  has_many :opening_hours
  has_many :dishes
  has_many :beverages
  has_many :menus
  has_many :orders
  has_many :employees
  has_many :markers
  has_many :discounts

  private 

  def validate_phone_number
    errors.add(:phone_number, 'é muito curto') if phone_number.length < 10 
    errors.add(:phone_number, 'é muito longo') if phone_number.length > 11
    errors.add(:phone_number, 'deve ter somente números') unless phone_number.match?(/\A\d+\z/)
  end

  def validate_cnpj
    errors.add(:restration_number, 'inválido') unless CNPJ.valid?(restration_number, strict: true)
  end

  def validate_email
    regra = /\A[^@\s]+@[^@\s]+\.[a-z]{2,}\z/
    errors.add(:email, 'inválido') unless regra.match(email)
  end

  def generate_code
    self.code = SecureRandom.alphanumeric(6).upcase
  end
end
