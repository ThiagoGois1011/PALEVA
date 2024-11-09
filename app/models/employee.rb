class Employee < User
  belongs_to :establishment
  
  def configurate_employee
    self.pre_registration_status = :pre_registration
    self.name = '.'
    self.last_name = '.'
    self.password = 'password_pre_register'
  end
end