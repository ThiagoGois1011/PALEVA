require 'rails_helper'

describe 'Dono vê os seus funcionários' do
  it 'do pre cadastro e com cadastro completo' do
    owner = create_owner(name: 'André')
    establishment = create_establishment_and_opening_hour(owner, corporate_name: 'Distribuidora Alimentícia Ifood', open_hour: '08:00', close_hour: '18:00')
    employee_1 = create_employee(establishment, name: 'Matheus', last_name: 'Silva Lopes', cpf: '95435037026', email: 'matheus@email.com', password: 'password5498')
    employee_2 = create_employee(establishment, name: 'João', last_name: 'Almeida', cpf: '07058622086', email: 'joao@email.com', password: 'password1234')
    pre_registration_1 = Employee.new(email: 'thiago@gmail.com', cpf: '99621154006', establishment: establishment)
    pre_registration_1.configurate_employee
    pre_registration_1.save!
    pre_registration_2 = Employee.new(email: 'juninho@gmail.com', cpf: '39747149010', establishment: establishment)
    pre_registration_2.configurate_employee
    pre_registration_2.save!

    login_as owner
    visit root_path
    click_on 'Funcionários'

    expect(page).to have_content('Nome: Matheus')
    expect(page).to have_content('CPF: 95435037026')
    expect(page).to have_content('Nome: João')
    expect(page).to have_content('CPF: 07058622086')
    expect(page).to have_content('Email: thiago@gmail.com')
    expect(page).to have_content('CPF: 99621154006')
    expect(page).to have_content('Email: juninho@gmail.com')
    expect(page).to have_content('CPF: 39747149010')

  end
end