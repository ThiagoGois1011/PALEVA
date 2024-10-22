require "cpf_cnpj"

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, :last_name, :cpf, presence: true 
  validates :cpf, uniqueness: true
  validate :valida_cpf

  private 

  def valida_cpf
    errors.add(:cpf, 'inválido') unless CPF.valid?(cpf, strict: true)
  end
end
