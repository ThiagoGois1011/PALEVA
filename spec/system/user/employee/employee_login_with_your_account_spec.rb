require 'rails_helper'

describe 'Funcionário faz o login' do
  it 'com sucesso' do
    owner = create_owner(name: 'André')
    establishment = create_establishment_and_opening_hour(owner, corporate_name: 'Distribuidora Alimentícia Ifood', open_hour: '08:00', close_hour: '18:00')
    employee = create_employee(establishment, name: 'João', email: 'joao@email.com', password: 'password9999')

    visit new_user_session_path
    fill_in 'Email', with: 'joao@email.com'
    fill_in 'Senha', with: 'password9999'
    within('form.new_user') do
      click_on 'Entrar'
    end

    expect(current_path).to eq(establishment_menus_path)
    expect(page).to have_content('Login efetuado com sucesso.')
  end

  it 'com conta do pré cadastro' do
    owner = create_owner(name: 'André')
    establishment = create_establishment_and_opening_hour(owner, corporate_name: 'Distribuidora Alimentícia Ifood', open_hour: '08:00', close_hour: '18:00')
    pre_registration = Employee.new(email: 'juninho@gmail.com', cpf: '99621154006', establishment: establishment)
    pre_registration.configurate_employee
    pre_registration.save!

    visit new_user_session_path
    fill_in 'Email', with: 'juninho@gmail.com'
    fill_in 'Senha', with: 'password_pre_register'
    within('form.new_user') do
      click_on 'Entrar'
    end

    
    expect(page).to have_content('Email ou senha inválidos.')
  end

  it 'e não vê botão de cadastrar funcionários' do
    owner = create_owner(name: 'André')
    establishment = create_establishment_and_opening_hour(owner, corporate_name: 'Distribuidora Alimentícia Ifood', open_hour: '08:00', close_hour: '18:00')
    employee = create_employee(establishment, name: 'João', email: 'joao@email.com', password: 'password9999')

    login_as employee
    visit establishment_menus_path

    expect(page).not_to have_content('Cadastrar novo Funcionário')
  end
end