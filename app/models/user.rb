
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, :last_name, :cpf, presence: true 
  validates :cpf, uniqueness: true
  validate :validate_cpf
  has_one :current_order, class_name: 'Order'
  enum :pre_registration_status, {owner: 0, pre_registration: 2, registration_complete: 4}

  private 

  def validate_cpf
    errors.add(:cpf, 'inválido') unless CPF.valid?(cpf, strict: true)
  end
end
