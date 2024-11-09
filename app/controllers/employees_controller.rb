class EmployeesController < ApplicationController
  def new
    @employee = Employee.new()
  end

  def create
    employee_params = params.require(:employee).permit(:cpf, :email)
    employee_params[:establishment] = current_user.establishment
  
    @employee = Employee.new(employee_params)
    @employee.configurate_employee

    if @employee.save
      redirect_to  establishment_menus_path(current_user.establishment) ,notice: 'Novo funcionário cadastrado com sucesso.'
    else
      flash.now[:notice] = 'Funcionário não cadastrado.'
      render :new
    end
  end
end