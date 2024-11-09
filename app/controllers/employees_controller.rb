class EmployeesController < ApplicationController
  skip_before_action :authenticate_user!, only:[:registration, :complete_registration]
  skip_before_action :check_current_user_type_for_page, only:[:registration, :complete_registration]

  def new
    @employee = Employee.new()
  end

  def create
    employee_params = params.require(:employee).permit(:cpf, :email)
    employee_params[:establishment] = current_establishment
  
    @employee = Employee.new(employee_params)
    @employee.configurate_employee

    if @employee.save
      redirect_to  establishment_menus_path ,notice: 'Novo funcionário cadastrado com sucesso.'
    else
      flash.now[:notice] = 'Funcionário não cadastrado.'
      render :new
    end
  end

  def registration
    @employee = Employee.new()
  end

  def complete_registration
    employee_params_search = params.require(:employee).permit(:email, :cpf)
    employee_params = params.require(:employee).permit(:name, :last_name, :password, :password_confirmation)
    employee_params[:pre_registration_status] = :registration_complete

    @employee = Employee.find_by(email: employee_params_search[:email], cpf: employee_params_search[:cpf])
    if @employee.nil?
      @employee = Employee.new(employee_params.merge(employee_params_search))
      @employee.valid?
      flash.now[:notice] = 'Email ou CPF incorreto'
      return render :registration
    end

    if @employee.update(employee_params)
      sign_in(@employee)
      redirect_to establishment_menus_path, notice: 'Cadastro do funcionário realizado com sucesso.'
    else
      flash.now[:notice] = 'Funcionário não cadastrado.'
      render :registration
    end
  end
end