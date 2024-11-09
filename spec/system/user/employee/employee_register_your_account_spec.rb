require 'rails_helper'

describe 'Funcionário cadastra sua conta' do
  it 'com sucesso' do
    owner = create_owner(name: 'André')
    establishment = create_establishment_and_opening_hour(owner, corporate_name: 'Distribuidora Alimentícia Ifood', open_hour: '08:00', close_hour: '18:00')
    pre_registration = Employee.new(email: 'juninho@gmail.com', cpf: '99621154006', establishment: establishment)
    pre_registration.configurate_employee
    pre_registration.save!

    visit root_path
    click_on 'Se cadastrar como funcionário'
    fill_in 'Nome', with: 'Junior'
    fill_in 'Sobrenome', with: 'Almeida'
    fill_in 'CPF', with: '99621154006'
    fill_in 'Email', with: 'juninho@gmail.com'
    fill_in 'Senha', with: 'password1234'
    fill_in 'Confirme sua senha', with: 'password1234'
    within('form') do
      click_on 'Cadastrar'
    end

    pre_registration.reload
    expect(current_path).to eq(establishment_menus_path(establishment))
    expect(page).to have_content('Cadastro do funcionário realizado com sucesso.')
    expect(pre_registration.pre_registration_status).to eq('registration_complete')
    expect(pre_registration.name).to eq('Junior') 
    expect(pre_registration.valid_password?('password1234')).to eq(true)
  end
end